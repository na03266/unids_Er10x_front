import 'package:flutter/material.dart';

// NOTE 제목 통합 스타일
TextStyle tStyle({
  required double size,
  Color color = Colors.white,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
  );
}

// NOTE 버튼 통합 스타일
TextStyle bStyle({
  required double size,
  bool isBold = true,
  Color color = Colors.white,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
    letterSpacing: -1,
  );
}

// NOTE 콘텐츠 통합 스타일
TextStyle cStyle({
  required double size,
  bool isBold = false,
  Color color = Colors.white,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
    letterSpacing: -1,
  );
}
