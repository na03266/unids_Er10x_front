import 'dart:typed_data';

import 'package:er10x/common/bluetooth/model/default_model.dart';
import 'package:er10x/common/bluetooth/util/crc_16.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_setting_model.g.dart';

enum SettingKeys {
  offset_1,
  offset_2,
  offset_3,
  offset_4,
  offset_5,
  offset_6,
  offset_7,
  offset_8,
  offset_9,
  offset_10;

  String get krName {
    switch (this) {
      case SettingKeys.offset_1:
        return '온도';
      case SettingKeys.offset_2:
        return '습도';
      case SettingKeys.offset_3:
        return '대기압';
      case SettingKeys.offset_4:
        return '포화수증기';
      case SettingKeys.offset_5:
        return '지온';
      case SettingKeys.offset_6:
        return '지습';
      case SettingKeys.offset_7:
        return 'EC';
      case SettingKeys.offset_8:
        return 'pH';
      case SettingKeys.offset_9:
        return 'CO2';
      case SettingKeys.offset_10:
        return '조도';
      }
  }
}

@JsonSerializable()
class DeviceSettingModel implements IDefaultModel {
  @JsonKey(name: 'default_offset')
  final DefaultOffset defaultOffset;
  final List<ExtendOffset> extend;

  DeviceSettingModel({
    required this.defaultOffset,
    required this.extend,
  });

  factory DeviceSettingModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceSettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSettingModelToJson(this);

  factory DeviceSettingModel.fromBinary(Uint8List data) {
    if (data.length != 44) {
      throw ArgumentError(
          'Invalid data length: ${data.length}, expected 44 bytes.');
    }

    if (!CRC16.validateCRC(data, data.length)) {
      throw ArgumentError('CRC validation failed. Data may be corrupted.');
    }

    final byteData = ByteData.sublistView(data);
    final offsets =
        List.generate(10, (i) => byteData.getFloat32(i * 4, Endian.little));

    return DeviceSettingModel(
      defaultOffset: DefaultOffset(
        offset_1: offsets[0],
        offset_2: offsets[1],
        offset_3: offsets[2],
        offset_4: offsets[3],
        offset_5: offsets[4],
        offset_6: offsets[5],
        offset_7: offsets[6],
        offset_8: offsets[7],
        offset_9: offsets[8],
        offset_10: offsets[9],
      ),
      extend: [],
    );
  }

  Uint8List toBinary() {
    final buffer = ByteData(44);
    final offsets = [
      defaultOffset.offset_1,
      defaultOffset.offset_2,
      defaultOffset.offset_3,
      defaultOffset.offset_4,
      defaultOffset.offset_5,
      defaultOffset.offset_6,
      defaultOffset.offset_7,
      defaultOffset.offset_8,
      defaultOffset.offset_9,
      defaultOffset.offset_10,
    ];
    for (int i = 0; i < offsets.length; i++) {
      buffer.setFloat32(i * 4, offsets[i], Endian.little);
    }
    buffer.setUint8(40, 0);
    buffer.setUint8(41, 0);
    CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 44);

    return buffer.buffer.asUint8List();
  }
}

// NOTE: 기본 오프셋
@JsonSerializable()
class DefaultOffset {
  // 온도
  @JsonKey(name: 'offset_1')
  final double offset_1;

  // 습도
  @JsonKey(name: 'offset_2')
  final double offset_2;

  // 대기압
  @JsonKey(name: 'offset_3')
  final double offset_3;

  // 포화수증기
  @JsonKey(name: 'offset_4')
  final double offset_4;

  // 지온
  @JsonKey(name: 'offset_5')
  final double offset_5;

  // 지습
  @JsonKey(name: 'offset_6')
  final double offset_6;

  // EC
  @JsonKey(name: 'offset_7')
  final double offset_7;

  // pH
  @JsonKey(name: 'offset_8')
  final double offset_8;

  // CO2
  @JsonKey(name: 'offset_9')
  final double offset_9;

  // 조도
  @JsonKey(name: 'offset_10')
  final double offset_10;

  DefaultOffset({
    required this.offset_1,
    required this.offset_2,
    required this.offset_3,
    required this.offset_4,
    required this.offset_5,
    required this.offset_6,
    required this.offset_7,
    required this.offset_8,
    required this.offset_9,
    required this.offset_10,
  });

  factory DefaultOffset.fromJson(Map<String, dynamic> json) =>
      _$DefaultOffsetFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultOffsetToJson(this);

  // 모든 필드를 Map으로 변환
  Map<String, double> toMap() {
    return {
      SettingKeys.offset_1.name: offset_1,
      SettingKeys.offset_2.name: offset_2,
      SettingKeys.offset_3.name: offset_3,
      SettingKeys.offset_4.name: offset_4,
      SettingKeys.offset_5.name: offset_5,
      SettingKeys.offset_6.name: offset_6,
      SettingKeys.offset_7.name: offset_7,
      SettingKeys.offset_8.name: offset_8,
      SettingKeys.offset_9.name: offset_9,
      SettingKeys.offset_10.name: offset_10,
    };
  }

  // 동적 접근 지원
  double getOffset(String key) {
    final map = toMap();
    return map[key] ?? 0.0; // 기본값 반환
  }
}

// NOTE: 확장
@JsonSerializable()
class ExtendOffset {
  // 1 ~ n
  @JsonKey(name: 'extend_id')
  final int extendId;

  // 485 온도 확장
  @JsonKey(name: 'extend_name')
  final String extendName;

  // -1.0
  @JsonKey(name: 'extend_offset')
  final double extendOffset;

  ExtendOffset({
    required this.extendId,
    required this.extendName,
    required this.extendOffset,
  });

  factory ExtendOffset.fromJson(Map<String, dynamic> json) =>
      _$ExtendOffsetFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendOffsetToJson(this);
}
