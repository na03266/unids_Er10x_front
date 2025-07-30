import 'package:dio/dio.dart' hide Headers;
import 'package:er10x/common/const/data.dart';
import 'package:er10x/common/dio/dio.dart';
import 'package:er10x/statistics/model/statistic_request_param.dart';
import 'package:er10x/statistics/model/statistic_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'statistic_repository.g.dart';

final statisticRepositoryProvider = Provider<StatisticRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return StatisticRepository(
    dio,
    baseUrl: '$ip/device-status-aggregate',
  );
});

@RestApi()
abstract class StatisticRepository {
  factory StatisticRepository(Dio dio, {String baseUrl}) = _StatisticRepository;
//
  // https://er10x.unids.kr/device-status-aggregate?deviceSettingId=1&intervalType=5m&startDate=2025-07-22&endDate=2025-07-28
  @GET('')
  Future<List<StatisticData>> getStatistic({
    @Queries() required StatisticRequestParam statisticRequestParam,
  });
}
