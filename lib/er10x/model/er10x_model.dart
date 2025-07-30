import 'package:freezed_annotation/freezed_annotation.dart';

part 'er10x_model.freezed.dart';
part 'er10x_model.g.dart';

@freezed
abstract class Er10xModel with _$Er10xModel {
  const factory Er10xModel({
    required String deviceId,
    String? deviceSerial,
    String? name,
  }) = _Er10xModel;

  factory Er10xModel.fromJson(Map<String, dynamic> json) =>
      _$Er10xModelFromJson(json);
}
