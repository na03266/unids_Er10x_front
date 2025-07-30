import 'package:er10x/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final double fontSize;
  final String title;
  final bool isOutlined;
  final Color? inputColor;
  final int? newNotification;
  final double? innerPadding;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.fontSize,
    required this.title,
    this.isOutlined = true,
    this.inputColor,
    this.newNotification,
    this.innerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: innerPadding == null
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: innerPadding!),
        side: BorderSide(color: inputColor ?? AppColors.primary),
        foregroundColor:
            isOutlined ? inputColor ?? AppColors.primary : Colors.white,
        backgroundColor:
            isOutlined ? Colors.white : inputColor ?? AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (newNotification != null) SizedBox(width: 10.w),
          Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1),
            ),
          ),
          if (newNotification != null) SizedBox(width: 10.w),
          if (newNotification != null)
            Padding(
              padding: EdgeInsets.only(top: 200.w),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  top: 2,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: isOutlined ? AppColors.primary : Colors.white,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 10.w,
                  minHeight: 10.w,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    newNotification.toString(),
                    style: TextStyle(
                        color: isOutlined ? Colors.white : AppColors.primary,
                        fontSize: 10.w,
                        fontWeight: FontWeight.w700,
                        height: 1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
