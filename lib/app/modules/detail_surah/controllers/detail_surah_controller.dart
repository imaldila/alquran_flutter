import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:alquran_flutter/repositories/detail_surah_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  Verse? lastVerse;

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
