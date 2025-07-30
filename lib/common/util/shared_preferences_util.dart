import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _sharedPreferences;

/// SharedPreferences 초기화 함수
Future<void> initializeSharedPreferences() async {
  _sharedPreferences = await SharedPreferences.getInstance();
}

/// Getter로 SharedPreferences 인스턴스 접근
SharedPreferences get sharedPreferences => _sharedPreferences;

/// SharedPreferences Helper 클래스 (CRUD 로직 추가)
class SharedPreferencesHelper {
  /// Key-Value 저장 (Create/Update)
  static Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  /// Key로 데이터 가져오기 (Read)
  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  /// Key에 해당하는 데이터 삭제 (Delete)
  static Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// 전체 데이터 삭제
  static Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  /// Key가 존재하는지 확인
  static bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }
}
