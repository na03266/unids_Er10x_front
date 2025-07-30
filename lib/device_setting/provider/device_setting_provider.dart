import 'dart:convert';

import 'package:er10x/common/mqtt/mqtt.dart';
import 'package:er10x/common/mqtt/mqtt_util.dart';
import 'package:er10x/device_setting/model/device_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../er10x/model/er10x_model.dart';
import '../../er10x/provider/er10x_provider.dart';

final deviceSettingProvider =
    StateNotifierProvider<DeviceSettingNotifier, OffsetStatus>(
  (ref) {
    final mqttRepository = ref.watch(mqttRepositoryProvider);
    final er10x = ref.watch(er10xProvider);
    return DeviceSettingNotifier(
      mqttRepository: mqttRepository,
      er10x: er10x,
    );
  },
);

class DeviceSettingNotifier extends StateNotifier<OffsetStatus> {
  final MqttRepository mqttRepository;
  final Er10xModel? er10x;

  DeviceSettingNotifier({
    required this.mqttRepository,
    this.er10x,
  }) : super(OffsetStatus.initial()) {
    subscribeToStatusUpdates();
  }

  // 상태 발행
  void publishStatus( DeviceSettingModel deviceSetting) {
    final mqttTopics = MqttTopics(deviceId: er10x?.deviceId ?? '');

    try {
      // 상태 데이터를 JSON으로 변환
      final payload = jsonEncode(deviceSetting.toJson());

      // MQTT 토픽에 메시지 발행
      mqttRepository.publish(mqttTopics.setting, payload);
      debugPrint('상태 발행 성공: $payload');
    } catch (e) {
      debugPrint('상태 발행 실패: $e');
    }
  }

  // 상태 업데이트 구독
  Future<void> subscribeToStatusUpdates() async {
    if (state.state == OffsetState.subscribe) {
      debugPrint('이미 구독 중 입니다.');
      return;
    }
    try {
      // MQTT 연결 상태 확인
      if (mqttRepository.client.connectionStatus?.state !=
          MqttConnectionState.connected) {
        // print('MQTT 연결이 없으므로 재연결 시도');
        await mqttRepository.connect(
          username: 'admin',
          password: '12345678',
          clientId: 'flutterUser',
        );
      }

      final mqttTopics = MqttTopics(deviceId: er10x?.deviceId ?? '');
      mqttRepository.subscribe(mqttTopics.setting);

      print('토픽 구독 성공: ${mqttTopics.setting}');

      // 메시지 수신 대기
      mqttRepository.listen(
        onMessage: (topic, payload) {
          if (topic == mqttTopics.setting) {
            try {
              print('MQTT payload: $payload');
              final decodedPayload =
                  jsonDecode(payload) as Map<String, dynamic>;
              final offsetModel = DeviceSettingModel.fromJson(decodedPayload);
              state = state.copyWith(
                state: OffsetState.data,
                data: offsetModel,
              );
              // print('상태 업데이트 성공: ${state.data!.toJson()}');
            } catch (e) {
              print('상태 메시지 파싱 실패: $e');
              state = state.copyWith(
                state: OffsetState.error,
                errorMessage: '상태 메시지 파싱 실패: $e',
              );
            }
          }
        },
        onError: (error) {
          print('상태 업데이트 수신 오류: $error');
          state = state.copyWith(
            state: OffsetState.error,
            errorMessage: '상태 업데이트 오류: $error',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        state: OffsetState.error,
        errorMessage: '구독 실패: $e',
      );
      print('구독 실패: $e');
    }
  }

  // 구독 취소
  void unsubscribeFromStatusUpdates() {
    try {
      if (mqttRepository.client.connectionStatus?.state !=
          MqttConnectionState.connected) {
        throw Exception('MQTT 연결이 끊어진 상태에서 구독 취소 요청됨.');
      }

      final mqttTopics = MqttTopics(deviceId: er10x?.deviceId ?? '');

      mqttRepository.unsubscribe(mqttTopics.setting);
      state = state.copyWith(state: OffsetState.unSubscribe, data: null);
      print('토픽 ${mqttTopics.setting} 구독 취소');
    } catch (e) {
      state = state.copyWith(
        state: OffsetState.error,
        errorMessage: '구독 취소 실패: $e',
      );
    }
  }
}

// 1. 연결만 됨
// 2. 연결되고 구독됨,
// 3. 연결 끈김,
// 4. 에러,
enum OffsetState {
  connected,
  disconnected,
  subscribe,
  unSubscribe,
  data,
  error
}

class OffsetStatus<T> {
  final OffsetState state;
  final DeviceSettingModel? data;
  final String? errorMessage; // 오류 메시지 추가

  OffsetStatus({
    required this.state,
    this.data,
    this.errorMessage,
  });

  factory OffsetStatus.initial() {
    return OffsetStatus(
      state: OffsetState.disconnected,
    );
  }

  OffsetStatus<T> copyWith({
    OffsetState? state,
    DeviceSettingModel? data,
    String? errorMessage,
  }) {
    return OffsetStatus<T>(
      state: state ?? this.state,
      data: data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
