import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/setting/sensor_info/component/errorWidget.dart';
import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/statistics/component/statistic_menu.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:er10x/statistics/model/statistic_response_model.dart';
import 'package:er10x/statistics/provider/statistic_provider.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/text_style.dart';
import '../component/custom_line_chart.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  static const routeName = 'statistics';
  final bool isShowingMainData;
  final SensorInfoModel sensorInfo;

  const StatisticScreen({
    super.key,
    required this.isShowingMainData,
    required this.sensorInfo,
  });

  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  StatisticData touchedSpotData = StatisticData(
    timeBucket: '',
    minValue: 0,
    maxValue: 0,
    avgValue: 0,
  );
  IntervalType intervalType = IntervalType.oneH;
  DateTime? startDate;
  DateTime? endDate;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    ref.read(statisticProvider(widget.sensorInfo).notifier).getStatistics();
  }

  _updateData() async {
    await ref.read(statisticProvider(widget.sensorInfo).notifier).getStatistics(
      intervalType: intervalType,
      sDate: startDate,
      eDate: endDate,
    );
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statisticProvider(widget.sensorInfo));

    if (state is StatisticResponseLoading) {
      return errorWidget('', isShowProgress: true);
    }
    if (state is StatisticResponseError) {
      return errorWidget(state.message);
    }

    state as StatisticDataList;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        context.go('/');
      },
      child: Container(
        color: AppColors.itemsBackground,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  border: Border.all(
                    color: AppColors.itemsBackground,
                    width: 4.w,
                  ),
                ),
                child: SizedBox(
                  height: 100.h,
                  width: 1000.w,
                  child: CustomLineChart(
                    intervalType: intervalType,
                    sensorInfo: widget.sensorInfo,
                    statisticDataList: state,
                    onTouched: (selectedData) {
                      setState(() {
                        touchedSpotData = selectedData;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: StatisticMenu(
                  selectedIntervalType: intervalType,
                  isExpanded: isExpanded,
                  changeIntervalType: (type) async {
                    setState(() {
                      intervalType = type;
                    });
                    _updateData();
                  },
                  onEnableDate: (startDate, endDate) async {
                    setState(() {
                      this.startDate = startDate;
                      this.endDate = endDate;
                    });
                    _updateData();

                  },
                  onExpanded: (expanded) {
                    setState(() {
                      isExpanded = expanded;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 40.w,
                ),
                child: _TouchedDataCard(
                  touchedSpotData: touchedSpotData,
                ),
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }
}

class _TouchedDataCard extends StatelessWidget {
  final StatisticData touchedSpotData;

  const _TouchedDataCard({
    required this.touchedSpotData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '선택 좌표 정보',
          style: tStyle(size: 35.sp),
        ),
        SizedBox(height: 2.h),
        rowData(
          title: '날짜:',
          data: touchedSpotData.formattedTime,
        ),
        rowData(
          title: '최대:',
          data: touchedSpotData.maxValueRounded.toString(),
          color: AppColors.contentColorPink,
        ),
        rowData(
          title: '평균:',
          data: touchedSpotData.avgValueRounded.toString(),
          color: AppColors.contentColorGreen,
        ),
        rowData(
          title: '최저:',
          data: touchedSpotData.minValueRounded.toString(),
          color: AppColors.contentColorCyan,
        ),
      ],
    );
  }

  Widget rowData({
    required String title,
    required String data,
    Color color = AppColors.contentColorWhite,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: tStyle(size: 30.sp).copyWith(color: color),
        ),
        SizedBox(width: 10.w),
        Text(
          data,
          style: tStyle(size: 30.sp).copyWith(color: color),
        ),
      ],
    );
  }
}
