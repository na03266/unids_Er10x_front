import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'statistic_response_model.freezed.dart';
part 'statistic_response_model.g.dart';

@freezed
sealed class StatisticResponseBase with _$StatisticResponseBase {
  const factory StatisticResponseBase.loading() = StatisticResponseLoading;

  const factory StatisticResponseBase.error({required String message}) =
      StatisticResponseError;

  const factory StatisticResponseBase.data({
    required List<StatisticData> data,
    required String startDate,
    required String endDate,
    required IntervalType intervalType,
    required SensorInfoModel sensorInfo,
  }) = StatisticDataList;

  factory StatisticResponseBase.fromJson(Map<String, dynamic> json) =>
      _$StatisticResponseBaseFromJson(json);
}

@unfreezed
abstract class StatisticData with _$StatisticData {
  factory StatisticData({
    required String timeBucket,
    required double minValue,
    required double maxValue,
    required double avgValue,
  }) = _StatisticData;

  factory StatisticData.fromJson(Map<String, dynamic> json) =>
      _$StatisticDataFromJson(json);
}
extension StatisticDataExtension on StatisticData {
  /// ✅ 시간 문자열 → DateTime으로 파싱
  DateTime get parsedTime =>
      DateTime.tryParse(timeBucket)?.toLocal() ?? DateTime(2000);

  /// ✅ 포맷된 시간 문자열 (예: yyyy-MM-dd HH:mm)
  String get formattedTime =>
      DateFormat('yyyy-MM-dd HH:mm').format(parsedTime);

  /// ✅ 소수점 2자리까지 반올림
  double get minValueRounded => double.parse(minValue.toStringAsFixed(2));
  double get maxValueRounded => double.parse(maxValue.toStringAsFixed(2));
  double get avgValueRounded => double.parse(avgValue.toStringAsFixed(2));
}
