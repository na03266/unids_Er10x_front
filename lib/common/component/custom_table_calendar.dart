import 'package:er10x/common/component/custom_button.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final double standardSize;
  final Function(DateTime? selectedDate) onPressed;

  const CustomTableCalendar({
    super.key,
    required this.standardSize,
    required this.onPressed,
  });

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.standardSize * 548,
      child: Padding(
        padding: EdgeInsets.all(widget.standardSize * 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '날짜선택',
                style: TextStyle(
                  fontSize: widget.standardSize * 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TableCalendar(
                  daysOfWeekVisible: true,
                  daysOfWeekHeight: widget.standardSize * 45,
                  rowHeight: widget.standardSize * 45,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) {
                      // 요일 축약
                      return [
                        'S',
                        'M',
                        'T',
                        'W',
                        'T',
                        'F',
                        'S'
                      ][date.weekday % 7];
                    },
                  ),
                  focusedDay: _focusedDay,
                  firstDay: DateTime(1800),
                  lastDay: DateTime(3000),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, _) {
                      return Container(
                        margin: EdgeInsets.all(widget.standardSize * 4),
                        // 셀 간격 조정
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.pageBackground, // 선택된 날짜 배경색
                        ),
                        alignment: Alignment.center,
                        height: widget.standardSize * 60,
                        // 선택된 날짜만 큰 높이
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: widget.standardSize * 16, // 텍스트 크기
                          ),
                        ),
                      );
                    },
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: widget.standardSize * 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.standardSize * 60,
              child: CustomButton(
                onPressed: () {
                  widget.onPressed(_selectedDay);
                  Navigator.pop(context);
                },
                fontSize: widget.standardSize * 20,
                title: '확인',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
