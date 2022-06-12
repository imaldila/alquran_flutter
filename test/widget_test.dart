import 'dart:convert';

import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:alquran_flutter/app/data/models/surah.dart';
import 'package:dio/dio.dart';

void main() async {
  var res = await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah");

  List data = (json.decode(res.data) as Map<String, dynamic>)["data"];
  // print(data);

  // dari data api (raw data) -> Model
  Surah surahAnnas = Surah.fromJson(data[113]);
  // print(surahAnnas.number);

  var resAnnas = await Dio().get(
      "https://quran-api-afrizaloky.herokuapp.com/surah/${surahAnnas.number!}");

  // print(resAnnas.data);

  var dataAnnas = (json.decode(resAnnas.data) as Map<String, dynamic>)["data"];

  // print(dataAnnas);

  // dari data api (raw data) -> Model
  DetailSurah annas = DetailSurah.fromJson(dataAnnas);
  print(annas.verses![1].number!.inQuran);
}
