import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      contentType: Headers.jsonContentType, // 'application/json'
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  return dio;
});