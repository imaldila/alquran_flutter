import 'package:alquran_flutter/repositories/juz_repository.dart';
import 'package:alquran_flutter/repositories/surah_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/models/detail_surah.dart';
import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class HomeController extends GetxController {
//  Future<List<Surah>> getAllSurah() async {
//     var res =
//         await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah");

//     List? data = (json.decode(res.data) as Map<String, dynamic>)["data"];

//     if (data == null || data.isEmpty) {
//       return [];
//     } else {
//       return data.map((e) => Surah.fromJson(e)).toList();
//     }
//   }

  final SurahRepository _surahRepository = SurahService();
  final JuzRepository _juzRepository = JuzService();
  RxBool isDark = false.obs;
  final RxList<Surah> _surah = <Surah>[].obs;
  List<Surah> get surah => _surah;

  final RxList<Juz> _allJuz = <Juz>[].obs;
  List<Juz> get allJuz => _allJuz;

  Future<List<Surah>> getAllSurah() async {
    try {
      var allSurah = await _surahRepository.getSurah();
      _surah.value = allSurah;
      update();
    } catch (e) {
      if (kDebugMode) {
        print('error getSurah: $e');
      }
    }
    return _surah;
  }

  // Future<List<Juz>> getAllJuz() async {
  //   try {
  //     for (int i = 1; i <= 30; i++) {
  //       var juz = await _juzRepository.getAllJuz(i);
  //       _allJuz.add(juz);
  //       update();
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('error getJuz: $e');
  //     }
  //   }
  //   return _allJuz;
  // }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;

    List<Map<String, dynamic>> penampungAyat = [];
    List<Map<String, dynamic>> allJuz = [];

    for (var i = 1; i < 115; i++) {
      var res =
          await Dio().get('https://quran-api-clone-one.vercel.app/surah/$i');
      // Map<String, dynamic> rawData = json.decode(res.data)['data'];
      DetailSurah data = DetailSurah.fromJson(res.data['data']);

      if (data.verses != null) {
        for (var ayat in data.verses!) {
          if (ayat.meta?.juz == juz) {
            penampungAyat.add({
              'surah': data.name?.transliteration?.id ?? '',
              'ayat': ayat,
            });
          } else {
            allJuz.add({
              'juz': juz,
              'start': penampungAyat[0],
              'end': penampungAyat[penampungAyat.length - 1],
              'verses': penampungAyat,
            });
            juz++;
            penampungAyat = [];
            penampungAyat.add({
              'surah': data.name?.transliteration?.id ?? '',
              'ayat': ayat,
            });
          }
        }
      }
    }

    allJuz.add({
      'juz': juz,
      'start': penampungAyat[0],
      'end': penampungAyat[penampungAyat.length - 1],
      'verses': penampungAyat,
    });
    return allJuz;
  }
}
