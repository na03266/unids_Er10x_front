// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceSettingModel _$DeviceSettingModelFromJson(Map<String, dynamic> json) =>
    DeviceSettingModel(
      defaultOffset: DefaultOffset.fromJson(
          json['default_offset'] as Map<String, dynamic>),
      extend: (json['extend'] as List<dynamic>)
          .map((e) => ExtendOffset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceSettingModelToJson(DeviceSettingModel instance) =>
    <String, dynamic>{
      'default_offset': instance.defaultOffset,
      'extend': instance.extend,
    };

DefaultOffset _$DefaultOffsetFromJson(Map<String, dynamic> json) =>
    DefaultOffset(
      offset_1: (json['offset_1'] as num).toDouble(),
      offset_2: (json['offset_2'] as num).toDouble(),
      offset_3: (json['offset_3'] as num).toDouble(),
      offset_4: (json['offset_4'] as num).toDouble(),
      offset_5: (json['offset_5'] as num).toDouble(),
      offset_6: (json['offset_6'] as num).toDouble(),
      offset_7: (json['offset_7'] as num).toDouble(),
      offset_8: (json['offset_8'] as num).toDouble(),
      offset_9: (json['offset_9'] as num).toDouble(),
      offset_10: (json['offset_10'] as num).toDouble(),
    );

Map<String, dynamic> _$DefaultOffsetToJson(DefaultOffset instance) =>
    <String, dynamic>{
      'offset_1': instance.offset_1,
      'offset_2': instance.offset_2,
      'offset_3': instance.offset_3,
      'offset_4': instance.offset_4,
      'offset_5': instance.offset_5,
      'offset_6': instance.offset_6,
      'offset_7': instance.offset_7,
      'offset_8': instance.offset_8,
      'offset_9': instance.offset_9,
      'offset_10': instance.offset_10,
    };

ExtendOffset _$ExtendOffsetFromJson(Map<String, dynamic> json) => ExtendOffset(
      extendId: (json['extend_id'] as num).toInt(),
      extendName: json['extend_name'] as String,
      extendOffset: (json['extend_offset'] as num).toDouble(),
    );

Map<String, dynamic> _$ExtendOffsetToJson(ExtendOffset instance) =>
    <String, dynamic>{
      'extend_id': instance.extendId,
      'extend_name': instance.extendName,
      'extend_offset': instance.extendOffset,
    };
