import 'dart:typed_data';

import 'package:er10x/common/bluetooth/util/crc_16.dart';

class SensorData {
  final double temp;
  final double humi;
  final int pascal;
  final int co2;
  final double etemp;
  final double ehumi;
  final double econd;
  final double ph;
  final double lux;
  final int watervapor;
  final int crcl;
  final int crch;

  SensorData({
    required this.temp,
    required this.humi,
    required this.pascal,
    required this.co2,
    required this.etemp,
    required this.ehumi,
    required this.econd,
    required this.ph,
    required this.lux,
    required this.watervapor,
    required this.crcl,
    required this.crch,
  });

  // 팩토리 메서드로 바이너리 데이터 파싱
  factory SensorData.fromBinary(Uint8List data) {
    if (data.length != 40) {
      throw ArgumentError(
          'Invalid data length: ${data.length}, expected 40 bytes.');
    }

    // CRC 검증
    if (!CRC16.validateCRC(data, data.length)) {
      throw ArgumentError('CRC validation failed. Data may be corrupted.');
    }

    final byteData = ByteData.sublistView(data);

    return SensorData(
      temp: byteData.getFloat32(0, Endian.big),
      humi: byteData.getFloat32(4, Endian.big),
      pascal: byteData.getUint16(8, Endian.big),
      co2: byteData.getUint16(10, Endian.big),
      etemp: byteData.getFloat32(12, Endian.big),
      ehumi: byteData.getFloat32(16, Endian.big),
      econd: byteData.getFloat32(20, Endian.big),
      ph: byteData.getFloat32(24, Endian.big),
      lux: byteData.getFloat32(28, Endian.big),
      watervapor: byteData.getUint16(32, Endian.big),
      crcl: byteData.getUint8(34),
      crch: byteData.getUint8(35),
    );
  }
}
