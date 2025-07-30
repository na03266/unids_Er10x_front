import 'dart:convert';

import 'package:er10x/common/mqtt/mqtt.dart';
import 'package:er10x/common/mqtt/mqtt_util.dart';
import 'package:er10x/er10x/model/er10x_model.dart';
import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/setting/sensor_info/provider/sensor_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../er10x/provider/er10x_provider.dart';

final statusProvider =
    StateNotifierProvider<StatusNotifier, SensorStatus<SensorInfoModel>>(
  (ref) {
    final mqttRepository = ref.watch(mqttRepositoryProvider);
    final sensorInfoList = ref.watch(sensorInfoProvider);
    final er10x = ref.watch(er10xProvider);
    return StatusNotifier(
      mqttRepository: mqttRepository,
      sensorInfoList: sensorInfoList,
      er10x: er10x,
    );
  },
);

class StatusNotifier extends StateNotifier<SensorStatus<SensorInfoModel>> {
  final MqttRepository mqttRepository;
  final Er10xModel? er10x;
  final List<SensorInfoModel> sensorInfoList;

  StatusNotifier({
    required this.sensorInfoList,
    required this.mqttRepository,
    this.er10x,
  }) : super(SensorStatus.initial()) {
    subscribeToStatusUpdates();
  }

  // 상태 업데이트 구독
  void subscribeToStatusUpdates() async {
    if (state.state == SensorState.subscribe) {
      // print('이미 구독 중 입니다.');
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
          clientId: 'flutterUser${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      final mqttTopics = MqttTopics(deviceId: er10x?.deviceId ?? '');
      mqttRepository.subscribe(mqttTopics.status);

      debugPrint('토픽 구독 성공: ${mqttTopics.status}');

      // 메시지 수신 대기
      mqttRepository.listen(
        onMessage: (topic, payload) {
          if (!mounted) return;

          if (topic == mqttTopics.status) {
            try {
              // debugPrint('MQTT payload: $payload');
              final decodedPayload =
                  jsonDecode(payload) as Map<String, dynamic>;
              final statusData = decodedPayload['status'];

              if (statusData == null || statusData is! Map<String, dynamic>) {
                throw Exception('유효하지 않은 상태 데이터');
              }

              final infoList = sensorInfoList.map((e) {
                final key = e.sensorId;
                final val = statusData[key];

                return e.copyWith(
                  value: val is num ? val.toDouble() : null,
                );
              }).toList();

              state = state.copyWith(
                state: SensorState.data,
                data: infoList,
              );
              // print('상태 업데이트 성공: ${state.data!.toJson()}');
            } catch (e) {
              // print('상태 메시지 파싱 실패: $e');
              state = state.copyWith(
                state: SensorState.error,
                errorMessage: '상태 메시지 파싱 실패: $e',
              );
            }
          }
        },
        onError: (error) {
          if (!mounted) return;
          state = state.copyWith(
            state: SensorState.error,
            errorMessage: '상태 업데이트 오류: $error',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        state: SensorState.error,
        errorMessage: '구독 실패: $e',
      );
      // print('구독 실패: $e');
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
      mqttRepository.unsubscribe(mqttTopics.status);
      state = state.copyWith(state: SensorState.unSubscribe, data: null);
      debugPrint('토픽 ${mqttTopics.status} 구독 취소');
    } catch (e) {
      state = state.copyWith(
        state: SensorState.error,
        errorMessage: '구독 취소 실패: $e',
      );
      debugPrint('구독 취소 실패: $e');
    }
  }

  @override
  void dispose() {
    if (er10x != null &&
        mqttRepository.client.connectionStatus?.state ==
            MqttConnectionState.connected) {
      mqttRepository.unsubscribe(MqttTopics(deviceId: er10x!.deviceId).status);
    }
    super.dispose();
  }
}

// 1. 연결만 됨
// 2. 연결되고 구독됨,
// 3. 연결 끈김,
// 4. 에러,
enum SensorState {
  connected,
  disconnected,
  subscribe,
  unSubscribe,
  data,
  error
}

class SensorStatus<T> {
  final SensorState state;
  final List<T>? data;
  final String? errorMessage; // 오류 메시지 추가

  SensorStatus({
    required this.state,
    this.data,
    this.errorMessage,
  });

  factory SensorStatus.initial() {
    return SensorStatus(
      state: SensorState.disconnected,
    );
  }

  SensorStatus<T> copyWith({
    SensorState? state,
    List<T>? data,
    String? errorMessage,
  }) {
    return SensorStatus<T>(
      state: state ?? this.state,
      data: data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
