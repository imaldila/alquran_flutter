import 'dart:convert';

import 'package:alquran_flutter/app/data/models/surah.dart';
import 'package:alquran_flutter/network/network_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class SurahRepository {
  Future<List<Surah>> getSurah();
}

class SurahService extends SurahRepository {
  Dio get _dio => NetworkDio.createDio();
  @override
  Future<List<Surah>> getSurah() async {
    try {
      Response response = await _dio.get('/surah');
      List? data = (json.decode(response.data) as Map<String, dynamic>)["data"];
      if (data == null || data.isEmpty) {
        return [];
      } else {
        return data.map((e) => Surah.fromJson(e)).toList();
      }
      // return Surah.fromJson(data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response!.data);
      }
      rethrow;
    }
  }
}
