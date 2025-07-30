import 'package:er10x/setting/sensor_info/model/sensor_info_model.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:er10x/statistics/model/statistic_response_model.dart';
import 'package:er10x/statistics/repository/statistic_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final statisticProvider = StateNotifierProvider.family<StatisticStateNotifier,
    StatisticResponseBase, SensorInfoModel>((ref, sensorInfo) {
  final repo = ref.watch(statisticRepositoryProvider);

  return StatisticStateNotifier(repository: repo, sensorInfo: sensorInfo);
});

class StatisticStateNotifier extends StateNotifier<StatisticResponseBase> {
  final StatisticRepository repository;
  final SensorInfoModel sensorInfo;

  StatisticStateNotifier({
    required this.repository,
    required this.sensorInfo,
  }) : super(const StatisticResponseLoading()) {
    getStatistics();
  }

  Future<void> getStatistics({
    IntervalType intervalType = IntervalType.oneH,
    DateTime? sDate,
    DateTime? eDate,
  }) async {
    try {
      final startDate = sDate?.toUtc().toIso8601String() ??
          DateTime.now()
              .subtract(const Duration(days: 1))
              .toUtc()
              .toIso8601String();
      final endDate = eDate?.toUtc().toIso8601String() ??
          DateTime.now().toUtc().toIso8601String();

      // 3. API 호출
      final response = await repository.getStatistic(
        statisticRequestParam: StatisticRequestParam(
          deviceSettingId: sensorInfo.id ?? 0,
          intervalType: intervalType,
          startDate: startDate,
          endDate: endDate,
        ),
      );
      // 4. 성공 상태로 업데이트
      state = StatisticResponseBase.data(
        data: response,
        startDate: formatToKstMinute(DateTime.parse(startDate)),
        endDate: formatToKstMinute(DateTime.parse(endDate)),
        intervalType: intervalType,
        sensorInfo: sensorInfo,
      );
    } catch (e) {
      // 5. 실패 상태로 업데이트
      state = StatisticResponseError(message: e.toString());
    }
  }
  String formatToKstMinute(DateTime date) {
    final kstDate = date.toLocal(); // UTC → KST
    return DateFormat('dd일').format(kstDate);
  }
}
