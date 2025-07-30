import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';
import 'custom_text_field.dart';

class CustomInputCard extends StatelessWidget {
  final String? hintTitle;
  final String? buttonTitle;
  final String? errorText;
  final Function()? onPressed;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final bool integerOnly;

  const CustomInputCard({
    super.key,
    required this.onSaved,
    required this.validator,
    this.buttonTitle,
    this.hintTitle,
    this.onPressed,
    this.integerOnly = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    // MediaQuery를 한 번만 호출

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hintTitle != null)//
            Expanded(
              child: SizedBox(
                height: 50.w,
                child: CustomTextField(
                  onSaved: onSaved,
                  validator: validator,
                  initialData: hintTitle!,
                  integerOnly: integerOnly,
                  errorText: errorText, hintStyle: cStyle(size: 20.w),
                ),
              ),
            ),
          // 온프레스 옵션이 들어오면 활성화 기본값은 비활성화
          if (onPressed != null)
            SizedBox(
              height: 40.w,
              child: CustomButton(
                onPressed: onPressed,
                fontSize: 16.w,
                title: buttonTitle!,
                isOutlined: false,
                innerPadding: 20,
              ),
            ),
        ],
      ),
    );
  }
}
