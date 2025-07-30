import 'dart:convert';

import 'package:er10x/common/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

import '../../er10x/model/er10x_model.dart';

class Er10xUtil {
  static const String _key = 'Er10x_list';

  static List<Er10xModel> defaultList = [
    const Er10xModel(deviceId: 'AABBCCDDEEFF'),
    const Er10xModel(deviceId: 'AABBCCDDEEFG'),
  ];

  /// Er10x 리스트 저장
  static Future<void> save(List<Er10xModel> list) async {
    try {
      final jsonList = list.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await SharedPreferencesHelper.setString(_key, jsonString);
    } catch (e) {
      debugPrint('Error saving Er10x list: $e');
      rethrow;
    }
  }

  /// 불러오기
  static Future<List<Er10xModel>> load() async {
    try {
      final loadedData = SharedPreferencesHelper.getString(_key);
      if (loadedData == null) return defaultList;

      final List<dynamic> jsonList = jsonDecode(loadedData);
      return jsonList.map((json) => Er10xModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading Er10x data: $e');
      return defaultList;
    }
  }
}
