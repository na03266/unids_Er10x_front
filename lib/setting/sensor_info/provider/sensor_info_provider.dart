import 'package:er10x/er10x/model/er10x_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../er10x/provider/er10x_provider.dart';
import '../model/sensor_info_model.dart';
import '../repository/sensor_info_repository.dart';

final sensorInfoProvider =
    StateNotifierProvider<SensorInfoNotifier, List<SensorInfoModel>>((ref) {
  final repository = ref.watch(sensorInfoRepositoryProvider);
  final er10x = ref.watch(er10xProvider);
  return SensorInfoNotifier(
    repository: repository,
    er10x: er10x,
  );
});

class SensorInfoNotifier extends StateNotifier<List<SensorInfoModel>> {
  final SensorInfoRepository repository;
  final Er10xModel? er10x;

  SensorInfoNotifier({
    required this.repository,
    required this.er10x,
  }) : super([]) {
    updateSensorInfoList();
  }

  sortSensorInfoList() {
    final sensorInfoList = state;

    state = sensorInfoList;
  }
  updateSensorInfoList() async {
    final sensorInfoList =
        await repository.getSensorInfoList(er10x?.deviceId ?? 'a');
    sortSensorInfoList();

    sensorInfoList.sort((a, b) {
      int parseSensorId(String? sensorId) {
        try {
          if (sensorId == null) return 0;
          final parts = sensorId.split('_');
          if (parts.length != 2 ) return 0;
          return int.parse(parts[1]);
        } catch (e) {
          return 0; // 파싱 실패 시 기본값
        }
      }

      final aId = parseSensorId(a.sensorId);
      final bId = parseSensorId(b.sensorId);

      if (aId == 0 && bId != 0) return 1;
      if (aId != 0 && bId == 0) return -1;
      return aId.compareTo(bId);
    });

    state = sensorInfoList;
  }

  patchSensorInfo(int id, SensorInfoModel sensorInfoModel) async {
    try {
      await repository.patchSensorInfo(id, sensorInfoModel);
      await updateSensorInfoList();
      return true;
    } catch (e) {
      return false;
    }
  }

  postSensorInfo(SensorInfoModel sensorInfoModel) async {
    try {
      await repository.postSensorInfo(sensorInfoModel);
      await updateSensorInfoList();
      return true;
    } catch (e) {
      return false;
    }
  }

  deleteSensorInfo(int id) async {
    try {
      await repository.deleteSensorInfo(id);
      await updateSensorInfoList();
      return true;
    } catch (e) {
      return false;
    }
  }
}
