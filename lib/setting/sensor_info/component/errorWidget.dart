import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/const/app_colors.dart';
import '../../../common/const/text_style.dart';

Widget errorWidget(String title, {bool isShowProgress = false}) {
  return Container(
    color: AppColors.pageBackground,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: tStyle(size: 35.w),
        ),
        SizedBox(
          height: 50.w,
        ),
        if (isShowProgress)
          const CircularProgressIndicator(color: Colors.white),
      ],
    ),
  );
}
