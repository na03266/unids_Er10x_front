import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final mqttRepositoryProvider = Provider<MqttRepository>((ref) {
  final client = ref.watch(mqttProvider);
  return MqttRepository(client);
});

final mqttProvider = Provider<MqttServerClient>((ref) {
  // MQTT 브로커 설정
  final client = MqttServerClient('121.146.250.230', 'flutterUser${DateTime.now().millisecondsSinceEpoch}');

  client.port = 51883; // 기본 포트
  client.keepAlivePeriod = 20; // Keep-alive 간격
  client.onDisconnected = () => print('MQTT 연결이 끊어졌습니다.');
  client.onConnected = () => print('MQTT에 연결되었습니다.');
  client.logging(on: false); // 디버그용 로깅 활성화


  return client;
});

class MqttRepository {
  final MqttServerClient client;

  MqttRepository(this.client);

// MQTT 연결
  Future<void> connect({
    required String username,
    required String password,
    required String clientId,
  }) async {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      debugPrint('이미 MQTT에 연결되어 있습니다.');
      return;
    }

    try {
      final connMessage = MqttConnectMessage()
          .authenticateAs(username, password) // 인증 정보
          .withClientIdentifier(clientId) // 클라이언트 식별자
          .withWillQos(MqttQos.atLeastOnce);

      client.connectionMessage = connMessage;

      await client.connect();
      print(client.connectionStatus?.state);
      print(client.connectionStatus?.returnCode);


    } catch (e) {
      print('MQTT 연결 실패: $e');
      client.disconnect();
      throw Exception('MQTT 연결 실패: $e'); // 예외를 다시 던짐
    }
  }

  // 특정 토픽 구독
  void subscribe(String topic, {MqttQos qos = MqttQos.atLeastOnce}) {
    client.subscribe(topic, qos);
    // print('토픽 [$topic] 구독 시작');
  }

  // 특정 토픽 구독 취소
  void unsubscribe(String topic) {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.unsubscribe(topic);
      debugPrint('[MQTT] Unsubscribed from $topic');
    } else {
      debugPrint('[MQTT] Already disconnected. Cannot unsubscribe $topic');
    }
  }

  // 메시지 발행
  void publish(String topic, String message,
      {MqttQos qos = MqttQos.atLeastOnce}) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, qos, builder.payload!, retain: true);
    // print('토픽 [$topic]로 메시지 발행: $message');
  }

  // 메시지 수신 대기 및 처리
  void listen({
    required Function(String topic, String payload) onMessage,
    Function(String error)? onError,
  }) {
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      try {
        final recMess = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        onMessage(c[0].topic, payload);
      } catch (e) {
        if (onError != null) {
          onError('메시지 수신 처리 중 오류 발생: $e');
        }
      }
    });
  }

  // 연결 해제
  void disconnect() {
    client.disconnect();
  }
}
