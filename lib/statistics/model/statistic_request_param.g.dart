// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_request_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatisticRequestParam _$StatisticRequestParamFromJson(
        Map<String, dynamic> json) =>
    _StatisticRequestParam(
      deviceSettingId: (json['deviceSettingId'] as num).toInt(),
      intervalType: $enumDecode(_$IntervalTypeEnumMap, json['intervalType']),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$StatisticRequestParamToJson(
        _StatisticRequestParam instance) =>
    <String, dynamic>{
      'deviceSettingId': instance.deviceSettingId,
      'intervalType': _$IntervalTypeEnumMap[instance.intervalType]!,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

const _$IntervalTypeEnumMap = {
  IntervalType.fiveM: '5m',
  IntervalType.tenM: '10m',
  IntervalType.oneH: '1h',
};
