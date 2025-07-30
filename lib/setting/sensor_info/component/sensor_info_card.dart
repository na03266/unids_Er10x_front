import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/const/app_colors.dart';

Widget sensorInfoCard({
  required Function() onPressed,
  required SensorInfoModel sensorInfo,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border.all(
          color: AppColors.white,
          width: 3.sp,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 5.h, 0, 5.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLabels('센서 ID: ', sensorInfo.sensorId),
                  _buildLabels('영문 표기: ', sensorInfo.name),
                  _buildLabels('센서 명칭: ', sensorInfo.krName),
                ],
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.settings),
              iconSize: 40.sp,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: AppColors.white,
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildLabels(title, value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 25.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}
