import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

FutureOr<bool> onExit(BuildContext context, state) async {
  // 특정 조건에 따라 경로 나가는 것을 제어
  final shouldLeave = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        '앱을 종료하시겠습니까?',
        style: tStyle(size: 20.w, color: Colors.black),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Stay
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), // Leave
          child: Text('Yes'),
        ),
      ],
    ),
  );

  // 사용자가 "Yes"를 눌렀을 때만 경로 전환 허용
  return shouldLeave ?? false;
}
