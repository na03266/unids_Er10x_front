import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<T> items;
  final String? title;
  final String Function(T) itemAsString;
  final void Function(T?) onChanged;
  final T? selectedItem;
  final bool isOutline;
  final double? width;
  final bool isEnabled;

  const CustomDropDown({
    super.key,
    required this.items,
    this.title,
    required this.itemAsString,
    required this.onChanged,
    required this.selectedItem,
    this.isOutline = false,
    this.width,
    this.isEnabled = true,
  });

//
  @override
  Widget build(BuildContext context) {
    final fontSize = 30.sp;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              color: AppColors.mainTextColor2,
              fontSize: fontSize,
              letterSpacing: -1,
            ),
          ),
          SizedBox(width: 15.w),
        ],
        Expanded(
          child: AbsorbPointer(
            absorbing: !isEnabled,
            child: DropdownButton<T>(
              dropdownColor: AppColors.white,

              isExpanded: true,
              value: selectedItem,
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemAsString(item),
                    style: TextStyle(
                      fontSize: fontSize,
                      color: AppColors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: isEnabled ? onChanged : null,
              underline: const SizedBox.shrink(),
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                fontSize: fontSize,
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
