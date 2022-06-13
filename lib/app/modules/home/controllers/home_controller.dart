import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/models/surah.dart';

class HomeController extends GetxController {
 Future<List<Surah>> getAllSurah() async {
    var res =
        await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah");

    List? data = (json.decode(res.data) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }
}
