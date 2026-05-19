import 'package:dio/dio.dart';

class DioService {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get<T>(path, queryParameters: queryParameters);
  }
}
