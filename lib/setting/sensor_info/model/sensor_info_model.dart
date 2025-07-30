import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_info_model.freezed.dart';
part 'sensor_info_model.g.dart';

@unfreezed
abstract class SensorInfoModel with _$SensorInfoModel {
  factory SensorInfoModel({
    @JsonKey(includeToJson: false) int? id,
    String? sensorId,
    String? name,
    String? krName,
    String? deviceId,
    double? maximum,
    double? minimum,
    String? unit,
    double? value,
  }) = _SensorInfoModel;

  factory SensorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SensorInfoModelFromJson(json);
}
