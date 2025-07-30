// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SensorInfoModel _$SensorInfoModelFromJson(Map<String, dynamic> json) =>
    _SensorInfoModel(
      id: (json['id'] as num?)?.toInt(),
      sensorId: json['sensorId'] as String?,
      name: json['name'] as String?,
      krName: json['krName'] as String?,
      deviceId: json['deviceId'] as String?,
      maximum: (json['maximum'] as num?)?.toDouble(),
      minimum: (json['minimum'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SensorInfoModelToJson(_SensorInfoModel instance) =>
    <String, dynamic>{
      'sensorId': instance.sensorId,
      'name': instance.name,
      'krName': instance.krName,
      'deviceId': instance.deviceId,
      'maximum': instance.maximum,
      'minimum': instance.minimum,
      'unit': instance.unit,
      'value': instance.value,
    };
