import 'dart:convert';

import 'package:alquran_flutter/app/data/models/ayat.dart';
import 'package:dio/dio.dart';

void main() async {
  var res =
      await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah/100/1");

  var data = json.decode(res.data)['data'];
  var dataToModel = {
    "number": data['number'],
    "meta": data['meta'],
    "text": data['text'],
    "translation": data['translation'],
    "audio": data['audio'],
    "tafsir": data['tafsir'],
  };

  // Convert Map -> ke Model Ayat
  Ayat ayat = Ayat.fromJson(dataToModel);
  print(ayat);

  // List data = (json.decode(res.data) as Map<String, dynamic>)["data"];
  // // print(data);

  // // dari data api (raw data) -> Model
  // Surah surahAnnas = Surah.fromJson(data[113]);
  // // print(surahAnnas.number);

  // var resAnnas = await Dio().get(
  //     "https://quran-api-afrizaloky.herokuapp.com/surah/${surahAnnas.number!}");

  // // print(resAnnas.data);

  // var dataAnnas = (json.decode(resAnnas.data) as Map<String, dynamic>)["data"];

  // // print(dataAnnas);

  // // dari data api (raw data) -> Model
  // DetailSurah annas = DetailSurah.fromJson(dataAnnas);
  // if (kDebugMode) {
  //   print(annas.verses![1].number!.inQuran);
  // }
}
