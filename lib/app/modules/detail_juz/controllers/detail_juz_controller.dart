import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/detail_surah.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  final player = AudioPlayer();

  Verse? lastVerse;

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
