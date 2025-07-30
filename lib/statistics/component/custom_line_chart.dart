import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/common/const/text_style.dart';
import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:er10x/statistics/model/statistic_response_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLineChart extends StatefulWidget {
  final IntervalType intervalType;
  final SensorInfoModel sensorInfo;
  final StatisticDataList statisticDataList;
  final Function(StatisticData) onTouched;

  const CustomLineChart({
    super.key,
    required this.intervalType,
    required this.statisticDataList,
    required this.onTouched,
    required this.sensorInfo,
  });

  @override
  State<StatefulWidget> createState() => CustomLineChartState();
}

class CustomLineChartState extends State<CustomLineChart> {
  bool isShowingMainData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 20.w,
        ),
        // note 차트 제목
        Text(
          '${widget.intervalType.label} 단위 ${widget.sensorInfo.krName}',
          style: cStyle(size: 30.w),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 37.w,
        ),
        // note 차트
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: _LineChart(
              model: widget.statisticDataList,
              onTouched: widget.onTouched,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _LineChart extends StatelessWidget {
  final StatisticDataList model;
  final Function(StatisticData) onTouched;

  const _LineChart({
    required this.model,
    required this.onTouched,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      modelData,
    );
  }

  get minY => model.data.map((e) => e.minValue).reduce((a, b) => a < b ? a : b);

  get maxY => model.data.map((e) => e.maxValue).reduce((a, b) => a > b ? a : b);

  LineChartData get modelData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: model.data.length - 1.toDouble(),
        maxY: maxY ,
        minY: minY ,
      );

  // note 라인 터치시 데이터 표시 여부
  LineTouchData get lineTouchData => LineTouchData(
        enabled: true,
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response != null && response.lineBarSpots != null) {
            final touchedSpot = response.lineBarSpots!.first.x.toInt();
            onTouched(model.data[touchedSpot]); // 상위로 데이터 전달
          }
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final value = spot.y.toStringAsFixed(2); // 소수점 2자리
              return LineTooltipItem(
                value,
                TextStyle(
                  fontSize: 25.sp,
                  height: 1,
                  color: spot.bar.color,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      );

  // note 차트 데이터
  List<LineChartBarData> get lineBarsData => [
        minData,
        avgData,
        maxData,
      ];

  LineChartBarData get minData => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorCyan,
        barWidth: 1.5.sp,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          model.data.length,
          (index) => FlSpot(index.toDouble(), model.data[index].minValue),
        ),
      );

  LineChartBarData get avgData => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorGreen,
        barWidth: 1.5.sp,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          model.data.length,
          (index) => FlSpot(index.toDouble(), model.data[index].avgValue),
        ),
      );

  LineChartBarData get maxData => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorPink,
        barWidth: 1.5.sp,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          model.data.length,
          (index) => FlSpot(index.toDouble(), model.data[index].maxValue),
        ),
      );

  // note 축 별 타이틀 표시 여부
  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  // note 왼쪽 타이틀
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    // 최소값과 최대값을 매칭
    if (value == minY) {
      text = minY.toStringAsFixed(0);
    } else if (value == maxY) {
      text = maxY.toStringAsFixed(0);
    } else {
      text = ''; // 표시하지 않을 값은 빈 문자열
    }

    return Text(text, style: cStyle(size: 15.w), textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  // note 바닥 타이틀
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = cStyle(size: 25.w);
    Widget text;

    if (value == 1) {
      text = Text(
        model.startDate,
        style: style,
      );
    } else if (value == model.data.length - 2) {
      text = Text(
        model.endDate,
        style: style,
      );
    } else {
      text = const Text(''); // 표시하지 않을 값은 빈 문자열
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  // note 격자
  FlGridData get gridData => const FlGridData(show: false);

  // note 사방 축 표시 여부
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.3), width: 3),
          left: BorderSide(color: AppColors.primary.withOpacity(0.3), width: 3),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
}
