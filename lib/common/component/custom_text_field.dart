import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String initialData;
  final String hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool integerOnly;
  final bool? isClip;
  final bool expand;

  const CustomTextField({
    super.key,
    this.onSaved,
    this.validator,
    this.onChanged,
    required this.initialData,
    this.hintText = '',
    this.hintStyle,
    this.errorText,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.nextFocusNode,
    this.integerOnly = false,
    this.isClip = false,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: _buildInputDecoration(),
      style: cStyle(size: 27.sp).copyWith(
        color: AppColors.contentColorBlack,
      ),
      initialValue: initialData,
      onSaved: onSaved,
      validator: validator,
      keyboardType: integerOnly ? TextInputType.number : TextInputType.text,
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      expands: expand,
      onChanged: onChanged,
      cursorColor: AppColors.contentColorBlack,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
        onFieldSubmitted?.call(value);
      },
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
        borderSide: const BorderSide(
          color: AppColors.contentColorPurple,
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      hintText: hintText,
      hintStyle: hintStyle ??
          cStyle(size: 30.w).copyWith(
            color: AppColors.contentColorBlack.withOpacity(0.5),
          ),
      errorText: errorText,
      errorStyle: const TextStyle(
        color: AppColors.contentColorCyan,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),

      filled: true,
      fillColor: Colors.white,
    );
  }
}
