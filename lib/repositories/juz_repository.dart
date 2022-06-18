import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app/data/models/juz.dart';
import '../network/network_dio.dart';

abstract class JuzRepository {
  Future<Juz> getAllJuz(int id);
}

class JuzService extends JuzRepository {
  Dio get _dio => NetworkDio.createDio();

  @override
  Future<Juz> getAllJuz(int id) async {
    try {
      Response response = await _dio.get('/juz/$id');
      Map<String, dynamic> data =
          (json.decode(response.data) as Map<String, dynamic>)["data"];
      return Juz.fromJson(data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response!.data);
      }
      rethrow;
    }
  }
}
