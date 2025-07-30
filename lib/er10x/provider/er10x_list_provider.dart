import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/er10x_model.dart';
import '../repository/er10x_repository.dart';

final er10xListProvider =
    StateNotifierProvider<Er10xListStateNotifier, List<Er10xModel>>((ref) {
  return Er10xListStateNotifier(repository: Er10xRepository());
});

class Er10xListStateNotifier extends StateNotifier<List<Er10xModel>> {
  final Er10xRepository repository;

  Er10xListStateNotifier({
    required this.repository,
  }) : super([]) {
    loadEr10xList();
  }

  Future<void> loadEr10xList() async {
    final list = await repository.load();
    state = list;
  }

  Future<void> saveEr10xList(List<Er10xModel> list) async {
    await repository.save(list);
    state = list;
  }

  Future<bool> addAndSaveEr10x(Er10xModel item) async {
    if (state.contains(item)) {
      return false;
    }
    final newList = [...state, item];

    state = newList;
    await saveEr10xList(newList);
    return true;
  }

  Future<bool> removeAndSaveEr10x(Er10xModel item) async {
    if (!state.contains(item)) {
      return false;
    }
    final newList = [...state];

    newList.remove(item);

    state = newList;

    await saveEr10xList(newList);

    return true;
  }

  editAndSaveEr10x(Er10xModel item) async {
    List<Er10xModel> newList = [...state];
    newList =
        newList.map((e) => e.deviceId == item.deviceId ? item : e).toList();

    await saveEr10xList(newList);

    return true;
  }
}
