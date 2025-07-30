import 'package:er10x/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  const CustomContainer({
    super.key,
    required this.child,
    this.decoration,
    this.padding,
  });

  // copyWith 메서드 구현
  CustomContainer copyWith({
    Widget? child,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
  }) {
    return CustomContainer(
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular( 8.w),
      ),
      padding: EdgeInsets.only(
        right:  20.w,
        top:  20.w,
      ),
      child: child,
    );
  }
}
