import 'package:alquran_flutter/app/data/db/bookmark.dart';
import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:alquran_flutter/constants/constant.dart';
import 'package:alquran_flutter/repositories/detail_surah_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqlite_api.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  Verse? lastVerse;

  final DetailSurahRepository _detailSurahRepository = DetailSurahService();
  final Rx<DetailSurah> _detailSurah = DetailSurah().obs;
  DetailSurah get detailSurah => _detailSurah.value;

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete('bookmark', where: 'last_read = 1');
    } else {
      List checkData = await db.query('bookmark',
          where:
              "surah == '${surah.name!.transliteration!.id}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        'bookmark',
        {
          'surah': '${surah.name!.transliteration!.id}',
          'ayat': ayat.number!.inSurah,
          'juz': ayat.meta!.juz,
          'via': 'surah',
          'index_ayat': indexAyat,
          'last_read': lastRead == true ? 1 : 0,
        },
      );
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil menambahkan bookmark',
          colorText: appWhite);
    } else {
      Get.back();
      Get.snackbar('Terjadi Kesalahan', 'Bookmark telah tersedia',
          colorText: appWhite);
    }
    var data = await db.query('bookmark');
    print(data);
  }

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

  void stopAudio(Verse verse) async {
    await player.stop();
    verse.audioStatus = 'stop';
    update();
  }

  void pauseAudio(Verse verse) async {
    await player.pause();
    verse.audioStatus = 'pause';
    update();
  }

  void resumeAudio(Verse verse) async {
    verse.audioStatus = 'playing';
    update();
    await player.play();
    verse.audioStatus = 'stop';
    update();
  }

  void playAudio(Verse verse) async {
    if (verse.audio?.primary != null) {
      try {
        lastVerse ??= verse;
        lastVerse!.audioStatus = 'stop';
        lastVerse = verse;
        lastVerse!.audioStatus = 'stop';
        update();
        await player.stop();
        await player.setUrl(verse.audio!.primary!);
        verse.audioStatus = 'playing';
        update();
        await player.play();
        verse.audioStatus = 'stop';
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: e.code.toString(),
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: 'Player Interrupted',
          middleText: 'Connection aborted:  ${e.message}',
        );
      } catch (e) {
        // Fallback for all errors
        Get.defaultDialog(
          title: 'Unknown error',
          middleText: 'Connection aborted:  $e',
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Audio not found',
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
