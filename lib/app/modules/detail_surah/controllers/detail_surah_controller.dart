import 'package:alquran_flutter/app/data/models/detail_surah.dart';
import 'package:alquran_flutter/repositories/detail_surah_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  RxString audioStatus = 'stop'.obs;

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

  void stopAudio() async {
    await player.stop();
    audioStatus.value = 'stop';
  }

  void pauseAudio() async {
    await player.pause();
    audioStatus.value = 'pause';
  }

  void resumeAudio() async {
    audioStatus.value = 'playing';
    await player.play();
    audioStatus.value = 'stop';
  }

  void playAudio(String? url) async {
    if (url != null) {
      try {
        await player.stop();
        await player.setUrl(url);
        audioStatus.value = 'playing';
        await player.play();
        audioStatus.value = 'stop';
        await player.stop();
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
