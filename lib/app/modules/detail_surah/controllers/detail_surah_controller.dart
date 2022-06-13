import 'dart:convert';

import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
  Future<DetailSurah> getDetailSurah(String id) async {
    var res =
        await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah/$id");

    Map<String, dynamic> data =
        (json.decode(res.data) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }
}
