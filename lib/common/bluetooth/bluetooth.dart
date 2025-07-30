import 'dart:async';
import 'dart:typed_data';

import 'package:er10x/common/bluetooth/model/default_model.dart';
import 'package:er10x/common/bluetooth/util/request_data.dart';
import 'package:er10x/device_setting/model/device_setting_model.dart';
import 'package:er10x/my_page/util/er10x_util.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../er10x/model/er10x_model.dart';

final bluetoothProvider =
    StateNotifierProvider<BluetoothNotifier, BluetoothState>(
  (ref) => BluetoothNotifier(),
);

class BluetoothState {
  final List<ScanResult> scanResults;
  final bool isConnected;
  final BluetoothDevice? connectedDevice;
  final BluetoothCharacteristic? writableCharacteristic;
  final IDefaultModel? data;
  final IDefaultModel? offsetData;
  final bool isScanning;
  final String? errorMessage;

  BluetoothState({
    this.scanResults = const [],
    this.isConnected = false,
    this.connectedDevice,
    this.writableCharacteristic,
    this.data,
    this.offsetData,
    this.isScanning = false,
    this.errorMessage,
  });

  BluetoothState copyWith({
    List<ScanResult>? scanResults,
    BluetoothDevice? connectedDevice,
    bool? isConnected,
    BluetoothCharacteristic? writableCharacteristic,
    IDefaultModel? data,
    IDefaultModel? offsetData,
    bool? isScanning,
    String? errorMessage,
  }) {
    return BluetoothState(
      scanResults: scanResults ?? this.scanResults,
      isConnected: isConnected ?? this.isConnected,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      writableCharacteristic:
          writableCharacteristic ?? this.writableCharacteristic,
      data: data ?? this.data,
      offsetData: offsetData ?? this.offsetData,
      isScanning: isScanning ?? this.isScanning,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class BluetoothNotifier extends StateNotifier<BluetoothState> {
  BluetoothNotifier() : super(BluetoothState());

  StreamSubscription<List<ScanResult>>? _scanResultSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;
  StreamSubscription<List<int>>? _notificationSubscription;
  Timer? _dataSendingTimer;

  /// 스캔 시작
  Future<void> startScan() async {
    try {
      await _scanResultSubscription?.cancel();
      await _ensureBluetoothEnabled();

      state =
          state.copyWith(scanResults: [], isScanning: true, errorMessage: null);

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 10),
        androidUsesFineLocation: true,
      );

      _scanResultSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          final uniqueResults = _filterUniqueResults(results);
          state = state.copyWith(scanResults: uniqueResults);
        },
        onError: (error) {
          _updateErrorState('스캔 중 오류 발생: $error');
        },
      );

      await FlutterBluePlus.isScanning.where((isScanning) => !isScanning).first;
    } catch (e) {
      _updateErrorState('스캔 중 예외 발생: $e');
    } finally {
      state = state.copyWith(isScanning: false);
    }
  }

  /// Bluetooth 사용 가능 여부 확인 및 활성화
  Future<void> _ensureBluetoothEnabled() async {
    try {
      if (!(await FlutterBluePlus.isSupported)) {
        throw Exception('블루투스를 사용할 수 없습니다.');
      }
      await FlutterBluePlus.turnOn();
    } catch (e) {
      _updateErrorState('블루투스 활성화 실패: $e');
      rethrow;
    }
  }

  /// 장치 연결
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);

      final characteristics = await _discoverCharacteristics(device);
      final writableChar = characteristics['write'];
      final notifyChar = characteristics['notify'];

      // 연결 상태 구독
      _subscribeConnectionState(device);

      // 알림 특성 구독
      if (notifyChar != null) _subscribeNotifications(notifyChar);

      // 상태 업데이트
      state = state.copyWith(
        isConnected: true,
        connectedDevice: device,
        writableCharacteristic: writableChar,
        errorMessage: null,
      );

      _saveDeviceToList(device);
      if (writableChar != null) startRequestOffsetData();

      // 주기적으로 센서 데이터 요청
      if (writableChar != null) _startRequestSensorData(writableChar);
    } catch (e) {
      _updateErrorState('연결 실패: $e');
      throw Exception('연결 실패: $e');
    }
  }

  /// 장치 연결 해제
  Future<void> disconnectDevice() async {
    final device = state.connectedDevice;
    if (device == null) {
      _updateErrorState('연결된 장치가 없습니다.');
      return;
    }

    try {
      await device.disconnect();
      _clearSubscriptions();

      // 상태 초기화
      state = state.copyWith(
        isConnected: false,
        connectedDevice: null,
        writableCharacteristic: null,
        data: null,
        errorMessage: null,
      );
      print('장치 연결이 해제되었습니다.');
    } catch (e) {
      _updateErrorState('연결 해제 실패: $e');
    }
  }

  /// 센서 데이터 주기적 요청
  void _startRequestSensorData(BluetoothCharacteristic writableCharacteristic) {
    _dataSendingTimer?.cancel();
    _dataSendingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      try {
        final payload = cmdDataToBytes();
        await writableCharacteristic.write(payload, withoutResponse: false);
        print('전송 성공: $payload');
      } catch (e) {
        print('데이터 전송 실패: $e');
        _dataSendingTimer?.cancel();
      }
    });
  }

  /// 오프셋 데이터 요청
  void startRequestOffsetData() async {
    final writableCharacteristic = state.writableCharacteristic;
    if (writableCharacteristic == null) {
      _updateErrorState('쓰기 가능한 특성을 찾을 수 없습니다.');
      return;
    }
    try {
      final payload = cmdOffsetDataToBytes();
      await writableCharacteristic.write(payload, withoutResponse: false);
      print('전송 성공: $payload');
    } catch (e) {
      print('데이터 전송 실패: $e');
    }
  }

  /// SSID 및 비밀번호 전송
  Future<void> sendCredentials(String ssid, String password) async {
    final writableCharacteristic = state.writableCharacteristic;

    if (writableCharacteristic == null) {
      _updateErrorState('쓰기 가능한 특성을 찾을 수 없습니다.');
      return;
    }

    if (ssid.isEmpty || password.isEmpty) {
      _updateErrorState('SSID와 비밀번호를 모두 입력해주세요.');
      return;
    }

    final payload = '$ssid$password'.codeUnits;
    print('Payload to Send (Bytes): $payload');

    try {
      await writableCharacteristic.write(payload, withoutResponse: false);
      print('자격 증명 전송 성공! Payload: $payload');
    } catch (e) {
      _updateErrorState('자격 증명 전송 실패: $e');
    }
  }

  /// 오프셋 데이터 전송
  Future<void> sendUint8List(Uint8List data) async {
    final writableCharacteristic = state.writableCharacteristic;

    try {
      await writableCharacteristic?.write(data, withoutResponse: false);
      print('자격 증명 전송 성공! Payload: $data');
    } catch (e) {
      _updateErrorState('자격 증명 전송 실패: $e');
    }
  }

  /// 특성 검색
  Future<Map<String, BluetoothCharacteristic?>> _discoverCharacteristics(
      BluetoothDevice device) async {
    BluetoothCharacteristic? writableChar;
    BluetoothCharacteristic? notifyChar;

    final services = await device.discoverServices();
    for (final service in services) {
      for (final characteristic in service.characteristics) {
        if (characteristic.properties.write && writableChar == null) {
          writableChar = characteristic;
        }
        if (characteristic.properties.notify && notifyChar == null) {
          notifyChar = characteristic;
        }
        if (writableChar != null && notifyChar != null) break;
      }
    }

    return {'write': writableChar, 'notify': notifyChar};
  }

  /// 연결 상태 구독
  void _subscribeConnectionState(BluetoothDevice device) {
    _connectionStateSubscription = device.connectionState.listen(
      (connectionState) {
        if (connectionState == BluetoothConnectionState.disconnected) {
          _handleDeviceDisconnection(device);
        }
      },
    );
  }

  /// 알림 특성 구독
  void _subscribeNotifications(BluetoothCharacteristic notifyChar) async {
    await notifyChar.setNotifyValue(true);
    _notificationSubscription = notifyChar.lastValueStream.listen((value) {
      try {
        if (value.length == 44) {
          final offsetModel =
              DeviceSettingModel.fromBinary(Uint8List.fromList(value));
          state = state.copyWith(offsetData: offsetModel);
        }
        print(value);
      } catch (e) {
        print('Error processing notification: $e');
      }
    });
  }

  /// 연결 해제 처리
  void _handleDeviceDisconnection(BluetoothDevice device) {
    print('장치 연결 끊김: ${device.platformName}');
    _clearSubscriptions();
    state = state.copyWith(
      isConnected: false,
      connectedDevice: null,
      writableCharacteristic: null,
      data: null,
      errorMessage: '장치 연결이 해제되었습니다.',
    );
  }

  /// 디바이스 목록 저장
  Future<void> _saveDeviceToList(BluetoothDevice device) async {
    final er10xList = await Er10xUtil.load();
    if (er10xList.any((e) => e.deviceId == device.platformName)) {
      print('장치가 이미 리스트에 존재합니다: ${device.platformName}');
      return;
    }

    er10xList.add(Er10xModel(deviceId: device.platformName));
    Er10xUtil.save(er10xList);
    print('새 장치 추가: ${device.platformName}');
  }

  /// 구독 및 타이머 정리
  void _clearSubscriptions() {
    _dataSendingTimer?.cancel();
    _connectionStateSubscription?.cancel();
    _notificationSubscription?.cancel();
  }

  /// 고유 결과 필터링
  List<ScanResult> _filterUniqueResults(List<ScanResult> results) {
    return results
        .where((result) => result.device.platformName.isNotEmpty)
        .toSet()
        .toList();
  }

  /// 상태 업데이트
  void _updateErrorState(String errorMessage) {
    state = state.copyWith(isScanning: false, errorMessage: errorMessage);
    print(errorMessage);
  }

  @override
  void dispose() {
    _scanResultSubscription?.cancel();
    _clearSubscriptions();
    FlutterBluePlus.stopScan();
    super.dispose();
  }
}
