import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:alquran_flutter/repositories/detail_surah_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
  // Future<DetailSurah> getDetailSurah(String id) async {
  //   var res =
  //       await Dio().get("https://quran-api-afrizaloky.herokuapp.com/surah/$id");

  //   Map<String, dynamic> data =
  //       (json.decode(res.data) as Map<String, dynamic>)["data"];

  //   return DetailSurah.fromJson(data);
  // }

  final DetailSurahRepository _detailSurahRepository = DetailSurahService();
  final Rx<DetailSurah> _detailSurah = DetailSurah().obs;
  DetailSurah get detailSurah => _detailSurah.value;

  Future<DetailSurah> getDetailSurah(int id) async {
    try {
      var detailSurah = await _detailSurahRepository.getDetailSurah(id);
      _detailSurah.value = detailSurah;
      update();
    } catch (e) {
      if (kDebugMode) {
        print('error getSurah: $e');
      }
    }
    return _detailSurah.value;
  }
}
