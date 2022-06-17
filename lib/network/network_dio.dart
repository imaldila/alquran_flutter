import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:developer' as dev;

class NetworkDio {
  static Dio createDio() {
    const String baseUrl = 'https://quran-api-afrizaloky.herokuapp.com';
    final option = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: 10 * 6000,
      receiveTimeout: 10 * 6000,
    );
    Dio dio = Dio(option);
    dio.interceptors.addAll(
      [
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          logPrint: (val) {
            dev.log(val.toString());
          },
        ),
      ],
    );
    return dio;
  }
}
