import 'dart:math';

import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgress extends StatelessWidget {
  final String name;
  final double value;
  final double maximum;
  final double minimum;
  final String unit;

  const CustomCircularProgress({
    super.key,
    required this.name,
    required this.value,
    required this.maximum,
    required this.minimum,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: _CircularProgressPainter(
        name: name,
        value: value,
        unit: unit,
        maximum: maximum,
        minimum: minimum,
        backgroundColor: Colors.grey.withAlpha(25),
        negativeForegroundColor: Colors.blue,
        positiveForegroundColor: AppColors.contentColorYellow,
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final String name;
  final double value;
  final double maximum;
  final double minimum;
  final Color backgroundColor;
  final Color negativeForegroundColor;
  final Color positiveForegroundColor;
  final String unit;

  _CircularProgressPainter({
    required this.value,
    required this.maximum,
    required this.minimum,
    required this.backgroundColor,
    required this.negativeForegroundColor,
    required this.positiveForegroundColor,
    required this.unit, required this.name,
  });

  int percentage = 0;
  double textScaleFactor = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    percentage = (value / maximum * 100).toInt();
    Paint paint = Paint() // 화면에 그릴 때 쓸 Paint를 정의합니다.
      ..color = backgroundColor
    // 선의 두께를 정합니다.
      ..strokeWidth = 25.sp
    // 선의 스타일. stroke: 외곽선만 or fill
      ..style = PaintingStyle.stroke
    // stroke의 스타일. round를 고르면 stroke의 끝이 둥글게 됩니다.
      ..strokeCap = StrokeCap.round;

    // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
    double radius = min(
      size.width / 2 - paint.strokeWidth / 2,
      size.height / 2 - paint.strokeWidth / 2,
    );
    // 원이 위젯의 가운데에 그려지게 좌표를 정함.
    Offset center = Offset(size.width / 2, size.height / 2);

    // 원을 그림.
    canvas.drawCircle(center, radius, paint);

    // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.
    double arcAngle = 2 * pi * (percentage / 100);

    // 호를 그릴 때는 색을 바꿔줌.
    paint
      ..color =
      percentage >= 0 ? positiveForegroundColor : negativeForegroundColor;

    // 호(arc) 그리기
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    );

    // 텍스트 표시.
    drawText(canvas, size, "$value $unit");
  }

  // 원의 중앙에 텍스트를 적음.
  void drawText(Canvas canvas, Size size, String text) {
    TextSpan sp = TextSpan(
      style: tStyle(size: 35.sp),
        children: [
          TextSpan(
            text: '$name\n',
            style: TextStyle(
                fontSize: 30.sp),
          ),
          TextSpan(text: text),
        ],
      ); // TextSpan은 Text위젯과 거의 동일하다.

      TextPainter tp = TextPainter(
      text: sp,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    tp.layout();
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) {
    return old.percentage != percentage;
  }
}
