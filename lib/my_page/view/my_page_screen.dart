import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/my_page/view/bluetooth_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'er10x_setting_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackground,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton('Bluetooth 장치 검색', () {
            context.pushNamed(BluetoothSettingScreen.routeName);
          }),
          _buildButton('Er10x 장치 설정', () {
            context.pushNamed(Er10XSettingScreen.routeName);
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String title, Function()? onPressed) {
    return SizedBox(
      height: 200.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.contentColorGreen,
          foregroundColor: AppColors.contentColorWhite,
          elevation: 5,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: tStyle(size: 40.sp).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
