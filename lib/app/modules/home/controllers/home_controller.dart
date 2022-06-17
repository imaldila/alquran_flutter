import 'package:alquran_flutter/repositories/surah_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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
  RxBool isDark = false.obs;
  final RxList<Surah> _surah = <Surah>[].obs;
  List<Surah> get surah => _surah;

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
}
