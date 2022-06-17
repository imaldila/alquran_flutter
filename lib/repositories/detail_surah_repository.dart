import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app/data/models/detail_surah.dart';
import '../network/network_dio.dart';

abstract class DetailSurahRepository {
  Future<DetailSurah> getDetailSurah(int id);
}

class DetailSurahService extends DetailSurahRepository {
  Dio get _dio => NetworkDio.createDio();
  @override
  Future<DetailSurah> getDetailSurah(int id) async {
    try {
      Response response = await _dio.get('/surah/$id');
      Map<String, dynamic> data =
          (json.decode(response.data) as Map<String, dynamic>)["data"];
      return DetailSurah.fromJson(data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response!.data);
      }
      rethrow;
    }
  }
}
