import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistic_request_param.freezed.dart';
part 'statistic_request_param.g.dart';

enum IntervalType {
  @JsonValue('5m')
  fiveM,
  @JsonValue('10m')
  tenM,
  @JsonValue('1h')
  oneH;

  String get label {
    switch (this) {
      case IntervalType.fiveM:
        return '5분';
      case IntervalType.tenM:
        return '10분';
      case IntervalType.oneH:
        return '1시간';
    }
  }
}

@freezed
abstract class StatisticRequestParam with _$StatisticRequestParam {
  const factory StatisticRequestParam({
    required int deviceSettingId,
    required IntervalType intervalType,
    required String startDate,
    required String endDate,
  }) = _StatisticRequestParam;

  factory StatisticRequestParam.fromJson(Map<String, dynamic> json) =>
      _$StatisticRequestParamFromJson(json);
}
