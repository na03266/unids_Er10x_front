import 'package:er10x/common/component/custom_text_field.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class StatisticMenu extends StatefulWidget {
  final IntervalType selectedIntervalType;
  final bool isExpanded;
  final Function(bool) onExpanded;
  final Function(IntervalType) changeIntervalType;
  final Function(DateTime?, DateTime?) onEnableDate;

  const StatisticMenu({
    super.key,
    required this.selectedIntervalType,
    required this.isExpanded,
    required this.changeIntervalType,
    required this.onEnableDate,
    required this.onExpanded,
  });

  @override
  State<StatisticMenu> createState() => _StatisticMenuState();
}

class _StatisticMenuState extends State<StatisticMenu> {
  String startDate = '';
  String endDate = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final boxStyle = BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(8.w));
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.itemsBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('주기 : ', style: tStyle(size: 30.w)),
              ...List.generate(
                IntervalType.values.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.changeIntervalType(IntervalType.values[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: widget.selectedIntervalType.index == index
                              ? AppColors.contentColorCyan
                              : AppColors.primary,
                        ),
                        child: Center(
                          child: Text(
                            IntervalType.values[index].label,
                            style: tStyle(size: 25.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onExpanded(!widget.isExpanded);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Container(
                    height: 15.h,
                    width: 70.w,
                    decoration: boxStyle.copyWith(
                      color: widget.isExpanded
                          ? AppColors.contentColorCyan
                          : AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.contentColorWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          if (widget.isExpanded)
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCustomTextField(
                    hint: '시작 :',
                    data: '',
                    onSaved: (value) => startDate = value ?? '',
                  ),
                  SizedBox(width: 10.w),
                  _buildCustomTextField(
                    hint: '종료 :',
                    data: '',
                    onSaved: (value) => endDate = value ?? '',
                  ),
                  GestureDetector(
                    onTap: _onSaved,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        height: 15.h,
                        width: 70.w,
                        decoration: boxStyle.copyWith(
                          color: AppColors.contentColorCyan,
                        ),
                        child: Center(
                          child: Text(
                            '적용',
                            style: tStyle(size: 25.w),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({
    required String hint,
    required String data,
    required Function(String?)? onSaved,
  }) {
    return Row(
      children: [
        Text(
          hint,
          style: tStyle(size: 30.w),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          height: 15.h,
          width: 200.w,
          child: CustomTextField(
            onSaved: onSaved,
            initialData: data,
            hintText: 'YYYYMMDD',
            integerOnly: true,
            hintStyle: cStyle(size: 25.w).copyWith(color: AppColors.grey),
          ),
        ),
      ],
    );
  }

  _onSaved() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();

    try {
      final DateTime? parsedStart = _parseDate(startDate);
      final DateTime? parsedEnd = _parseDate(endDate);

      if (parsedStart == null || parsedEnd == null) {
        throw FormatException('날짜 파싱 실패');
      }

      widget.onEnableDate(parsedStart, parsedEnd);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  DateTime? _parseDate(String input) {
    input = input.trim().replaceAll(RegExp(r'[^\d]'), ''); // ✅ 핵심 라인

    try {
      if (RegExp(r'^\d{8}$').hasMatch(input)) {
        // 올바른 패턴 사용
        return DateFormat('yyyyMMdd').parseStrict(input);
      } else if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) {
        return DateFormat('yyyy-MM-dd').parseStrict(input);
      } else {
        return null;
      }
    } catch (e) {
      // 수동으로 파싱 시도
      if (input.length == 8) {
        try {
          final year = int.parse(input.substring(0, 4));
          final month = int.parse(input.substring(4, 6));
          final day = int.parse(input.substring(6, 8));

          return DateTime(year, month, day);
        } catch (manualParseError) {
          return null;
        }
      }
      return null;
    }
  }
}
