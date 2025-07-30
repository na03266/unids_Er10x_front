import 'package:flutter/material.dart';

import '../const/app_colors.dart';

class CustomTimePicker extends StatefulWidget {
  final double standardSize;
  final Function(int hour, int minute, bool isAM) onTimeSelected;
  final TimeOfDay? initialTime;
  final double height;
  final double width;

  const CustomTimePicker({
    super.key,
    required this.onTimeSelected,
    this.initialTime,
    required this.standardSize,
    required this.height,
    required this.width,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAM;
  late double shellWidth;

  @override
  void initState() {
    super.initState();
    final hour = widget.initialTime?.hour ?? DateTime.now().hour;
    isAM = hour < 12;
    selectedHour = isAM ? hour : hour - 12;
    if (selectedHour == 0) selectedHour = 12;
    selectedMinute = widget.initialTime?.minute ?? DateTime.now().minute;
    shellWidth = widget.height / 3;
  }

  // 공통 스타일을 반환하는 함수
  TextStyle getPickerTextStyle(bool isSelected) {
    return TextStyle(
      fontSize: widget.standardSize * 20,
      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
      color: isSelected ? Colors.black : Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.height,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 8),

                _buildNumberPicker(
                  value: selectedHour,
                  minValue: 1,
                  maxValue: 12,
                  onSelected: (value) {
                    setState(() {
                      selectedHour = value;
                      widget.onTimeSelected(selectedHour, selectedMinute, isAM);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ':',
                    style: TextStyle(
                      fontSize: widget.standardSize * 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildNumberPicker(
                  value: selectedMinute,
                  minValue: 0,
                  maxValue: 59,
                  onSelected: (value) {
                    setState(() {
                      selectedMinute = value;
                      widget.onTimeSelected(selectedHour, selectedMinute, isAM);
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildAMPMPicker(),
                const SizedBox(width: 8),

              ],
            ),
          ),
          // 상단 구분선
          _Divider(isTop: true),
          // 하단 구분선
          _Divider(isTop: false),
        ],
      ),
    );
  }

  Widget _buildAMPMPicker() {
    return SizedBox(
      width: shellWidth,
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(initialItem: isAM ? 0 : 1),
        itemExtent: shellWidth,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            isAM = index == 0;
            widget.onTimeSelected(selectedHour, selectedMinute, isAM);
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 2,
          builder: (context, index) {
            final isSelected = (index == 0 && isAM) || (index == 1 && !isAM);
            return Container(
              alignment: Alignment.center,
              child: Text(
                index == 0 ? '오전' : '오후',
                style: getPickerTextStyle(isSelected),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNumberPicker({
    required int value,
    required int minValue,
    required int maxValue,
    required Function(int) onSelected,
  }) {
    return SizedBox(
      width: shellWidth,
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(initialItem: value - minValue),
        itemExtent: shellWidth,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onSelected(index + minValue),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index > maxValue - minValue) return null;
            final number = index + minValue;
            return Container(
              alignment: Alignment.center,
              child: Text(
                number.toString(),
                style: getPickerTextStyle(number == value),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _Divider({required bool isTop}) {
    const double height = 2;
    return Positioned(
      top: isTop ? shellWidth : null,
      bottom: isTop ? null : shellWidth,
      // itemExtent(60)의 1/3 위치
      left: 0,
      right: 0,
      child: Row(
        children: [
          SizedBox(width: widget.width/10),
          Expanded(
            child: Container(
              height: height,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          SizedBox(width: widget.width/10),Expanded(
            child: Container(
              height: height,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          SizedBox(width: widget.width/10), Expanded(
            child: Container(
              height: height,
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          SizedBox(width: widget.width / 10),
        ],
      ),
    );
  }
}
