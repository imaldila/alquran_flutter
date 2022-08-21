import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/constant.dart';
import '../../../data/models/detail_surah.dart' as detail;
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  DetailJuzView({Key? key}) : super(key: key);

  final Map<String, dynamic> dataMapPerJuz = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${dataMapPerJuz['juz']}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (dataMapPerJuz['verses'] as List).length,
          itemBuilder: (BuildContext context, int index) {
            if ((dataMapPerJuz['verses'] as List).isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }
            Map<String, dynamic> ayat = dataMapPerJuz['verses'][index];
            detail.DetailSurah surah = ayat['surah'];
            detail.Verse verses = ayat['ayat'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if ((ayat['ayat'] as detail.Verse).number!.inSurah == 1)
                  GestureDetector(
                    onTap: () => Get.defaultDialog(
                      titlePadding: const EdgeInsets.all(16),
                      title:
                          'Tafsir ${surah.name?.transliteration?.id ?? 'Error'}',
                      titleStyle: const TextStyle(fontSize: 20),
                      contentPadding: const EdgeInsets.all(16),
                      content: Text(
                        '${surah.tafsir?.id}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    child: Container(
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            appPurpleDark2,
                            appPurpleDark1,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              '${surah.name!.transliteration!.id}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: appWhite,
                              ),
                            ),
                            Text(
                              '( ${surah.name?.translation?.id ?? 'Error'} )',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: appWhite,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? ''}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: appWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: appPurpleLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img_octagonal.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                    '${(ayat['ayat'] as detail.Verse).number?.inSurah ?? ''}'),
                              ),
                            ),
                            Text(
                              '${surah.name!.transliteration!.id}',
                              style: const TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GetBuilder<DetailJuzController>(
                              builder: (c) => Row(
                                children: [
                                  (verses.audioStatus == 'stop')
                                      ? IconButton(
                                          onPressed: () {
                                            c.playAudio(verses);
                                          },
                                          icon: const Icon(Icons.play_arrow),
                                        )
                                      : Row(
                                          children: [
                                            (verses.audioStatus == 'playing')
                                                ? IconButton(
                                                    onPressed: () {
                                                      c.pauseAudio(verses);
                                                    },
                                                    icon: const Icon(
                                                      Icons.pause,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      c.resumeAudio(verses);
                                                    },
                                                    icon: const Icon(
                                                      Icons.play_arrow,
                                                    ),
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                c.stopAudio(verses);
                                              },
                                              icon: const Icon(
                                                Icons.stop,
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    (ayat['ayat'] as detail.Verse).text?.arab ?? 'Error',
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (ayat['ayat'] as detail.Verse).text?.transliteration?.en ??
                      'Error',
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  (ayat['ayat'] as detail.Verse).translation?.id ?? 'Error',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
