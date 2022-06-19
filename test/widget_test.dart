import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:dio/dio.dart';

void main() async {
  int juz = 1;

  List<Map<String, dynamic>> penampungAyat = [];
  List<Map<String, dynamic>> allJuz = [];

  for (var i = 1; i < 114; i++) {
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
          print('==========================');
          print('Berhasil memasukan Juz $juz');
          print('Start');
          print(
              'Ayat : ${(penampungAyat[0]['ayat'] as Verse).number?.inSurah}');
          print('${(penampungAyat[0]['ayat'] as Verse).text?.arab}');
          print('End');
          print(
              'Ayat : ${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).number?.inSurah}');
          print(
              '${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).text?.arab}');
          allJuz.add({
            'juz': juz,
            'start': penampungAyat[0],
            'end': penampungAyat[penampungAyat.length - 1],
            'verses': penampungAyat,
          });
          juz++;
          penampungAyat.clear();
          penampungAyat.add({
            'surah': data.name?.transliteration?.id ?? '',
            'ayat': ayat,
          });
        }
      }
    }
  }
  print('==========================');
  print('Berhasil memasukan Juz $juz');
  print('Start');
  print('Ayat : ${(penampungAyat[0]['ayat'] as Verse).number?.inSurah}');
  print('${(penampungAyat[0]['ayat'] as Verse).text?.arab}');
  print('End');
  print(
      'Ayat : ${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).number?.inSurah}');
  print(
      '${(penampungAyat[penampungAyat.length - 1]['ayat'] as Verse).text?.arab}');
  allJuz.add({
    'juz': juz,
    'start': penampungAyat[0],
    'end': penampungAyat[penampungAyat.length - 1],
    'verses': penampungAyat,
  });
  juz++;
  penampungAyat.clear();
  // penampungAyat.add({
  //   'surah': data.name?.transliteration?.id ?? '',
  //   'ayat': ayat,
  // });
}
