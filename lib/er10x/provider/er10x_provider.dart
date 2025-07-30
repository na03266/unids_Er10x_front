import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/er10x_model.dart';

final er10xProvider =
    StateNotifierProvider<Er10xStateNotifier, Er10xModel?>((ref) {
  return Er10xStateNotifier();
});

class Er10xStateNotifier extends StateNotifier<Er10xModel?> {
  Er10xStateNotifier() : super(null);

  void set(Er10xModel model) {
    state = model;
  }
}
