import 'package:er10x/setting/sensor_info/view/sensor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/app_colors.dart';
import '../../common/const/error_message.dart';
import '../../common/const/text_style.dart';
import '../../er10x/provider/er10x_provider.dart';
import '../sensor_info/component/errorWidget.dart';
import '../sensor_offset/device_offset_screen.dart';

class SettingScreen extends ConsumerWidget {
  static String routeName = 'device-setting';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final er10x = ref.watch(er10xProvider);

    // if (er10x == null) return errorWidget(deviceNotFound);

    return Container(
      color: AppColors.pageBackground,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButton('센서 정보 설정', () {
              context.pushNamed(SensorInfoScreen.routeName);
            }),
            SizedBox(height: 10.h),
            _buildButton('센서 오프셋 설정', () {
              context.pushNamed(DeviceOffsetScreen.routeName);
            }),
          ],
        ),
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
