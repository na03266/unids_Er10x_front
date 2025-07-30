import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../common/const/data.dart';
import '../../../common/dio/dio.dart';
import '../model/sensor_info_model.dart';

part 'sensor_info_repository.g.dart';

final sensorInfoRepositoryProvider = Provider<SensorInfoRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return SensorInfoRepository(dio, baseUrl: '$ip/device-setting/');
});

@RestApi()
abstract class SensorInfoRepository {
  factory SensorInfoRepository(Dio dio, {String baseUrl}) =
      _SensorInfoRepository;

  @GET('{device_id}')
  Future<List<SensorInfoModel>> getSensorInfoList(
    @Path('device_id') String id,
  );

  @POST('')
  Future<void> postSensorInfo(
    @Body() SensorInfoModel deviceInfoModel,
  );

  @PATCH('{id}')
  Future<void> patchSensorInfo(
    @Path('id') int id,
    @Body() SensorInfoModel deviceInfoModel,
  );

  @DELETE('{id}')
  Future<void> deleteSensorInfo(
    @Path('id') int id,
  );
}
