// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticResponseLoading _$StatisticResponseLoadingFromJson(
        Map<String, dynamic> json) =>
    StatisticResponseLoading(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StatisticResponseLoadingToJson(
        StatisticResponseLoading instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

StatisticResponseError _$StatisticResponseErrorFromJson(
        Map<String, dynamic> json) =>
    StatisticResponseError(
      message: json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StatisticResponseErrorToJson(
        StatisticResponseError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

StatisticDataList _$StatisticDataListFromJson(Map<String, dynamic> json) =>
    StatisticDataList(
      data: (json['data'] as List<dynamic>)
          .map((e) => StatisticData.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      intervalType: $enumDecode(_$IntervalTypeEnumMap, json['intervalType']),
      sensorInfo:
          SensorInfoModel.fromJson(json['sensorInfo'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StatisticDataListToJson(StatisticDataList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'intervalType': _$IntervalTypeEnumMap[instance.intervalType]!,
      'sensorInfo': instance.sensorInfo,
      'runtimeType': instance.$type,
    };

const _$IntervalTypeEnumMap = {
  IntervalType.fiveM: '5m',
  IntervalType.tenM: '10m',
  IntervalType.oneH: '1h',
};

_StatisticData _$StatisticDataFromJson(Map<String, dynamic> json) =>
    _StatisticData(
      timeBucket: json['timeBucket'] as String,
      minValue: (json['minValue'] as num).toDouble(),
      maxValue: (json['maxValue'] as num).toDouble(),
      avgValue: (json['avgValue'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticDataToJson(_StatisticData instance) =>
    <String, dynamic>{
      'timeBucket': instance.timeBucket,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'avgValue': instance.avgValue,
    };
