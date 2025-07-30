import 'package:er10x/common/component/custom_circular_progress.dart';
import 'package:er10x/common/const/app_colors.dart';
import 'package:er10x/setting/sensor_info/component/errorWidget.dart';
import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/statistics/view/statistic_screen.dart';
import 'package:er10x/status/provider/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StatusScreen extends ConsumerStatefulWidget {
  static String get routeName => '/';

  const StatusScreen({super.key});

  @override
  ConsumerState<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    // 데이터를 갱신하거나 필요한 작업 수행
    await Future.delayed(const Duration(microseconds: 500)); // 예: 네트워크 요청 대기
    ref.read(statusProvider.notifier).subscribeToStatusUpdates();
  }

  @override
  Widget build(BuildContext context) {
    final mqttState = ref.watch(statusProvider);

    final List<SensorInfoModel> statusDataList = mqttState.data ?? [];

    if (statusDataList.isEmpty) {
      return GestureDetector(
          onTap: () {
            _onRefresh();
          },
          child: errorWidget('장치를 선택해주세요'));
    }

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.white,
      onRefresh: _onRefresh,
      child: Container(
        color: AppColors.pageBackground,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            border: Border.all(
              color: AppColors.itemsBackground,
              width: 4.w,
            ),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.w,
            padding: EdgeInsets.all(20.w),
            children: statusDataList
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      context.goNamed(
                        StatisticScreen.routeName,
                        extra: e, // 'param'에 '123' 전달
                      );
                    },
                    child: CustomCircularProgress(
                      name: e.krName ?? '',
                      value: _roundToOneDecimal(e.value),
                      maximum: e.maximum ?? 100,
                      minimum: e.minimum ?? 0,
                      unit: e.unit ?? '',
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  double _roundToOneDecimal(double? value) {
    return value != null ? (value * 10).round() / 10.0 : 0.0;
  }
}
