import 'dart:convert';

class MqttTopics {
  final String deviceId;

  MqttTopics({
    required this.deviceId,
  });

  String get status => 'status/$deviceId';
  String get setting => 'setting/$deviceId';
}

class MqttMessageParser {
  static T parsePayload<T>(
      String payload, T Function(Map<String, dynamic>) fromJson) {
    final Map<String, dynamic> jsonData = jsonDecode(payload);
    return fromJson(jsonData);
  }
}
