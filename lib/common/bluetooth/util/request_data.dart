import 'dart:typed_data';

import 'package:er10x/common/bluetooth/util/crc_16.dart';

/// 셋업 데이터 요청 함수
Uint8List cmdDataToBytes() {
  final buffer = ByteData(4);
  buffer.setUint8(0, 1); // 첫 번째 명령어
  buffer.setUint8(1, 0); // 두 번째 명령어

  // calculateCRC16m이 자동으로 마지막 2바이트에 CRC를 넣어줍니다
  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 4);

  print('Final payload: ${buffer.buffer.asUint8List()}');
  return buffer.buffer.asUint8List();
}

/// 오프셋 데이터 요청 함수
Uint8List cmdOffsetDataToBytes() {
  final buffer = ByteData(4);
  buffer.setUint8(0, 2); // 첫 번째 명령어
  buffer.setUint8(1, 0); // 두 번째 명령어

  // calculateCRC16m이 자동으로 마지막 2바이트에 CRC를 넣어줍니다
  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 4);

  print('Final payload: ${buffer.buffer.asUint8List()}');
  return buffer.buffer.asUint8List();
}