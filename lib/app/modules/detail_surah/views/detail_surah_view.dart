import 'package:alquran_flutter/app/data/models/detail_surah.dart' as detail;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/constant.dart';
import '../../../data/models/surah.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  const DetailSurahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${surah.name?.transliteration?.id ?? 'Error'}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.defaultDialog(
              titlePadding: const EdgeInsets.all(16),
              title: 'Tafsir ${surah.name?.transliteration?.id ?? 'Error'}',
              titleStyle: const TextStyle(fontSize: 20),
              contentPadding: const EdgeInsets.all(16),
              content: Text(
                '${surah.tafsir?.id}',
                textAlign: TextAlign.left,
              ),
            ),
            child: Container(
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
                      surah.name?.transliteration?.id ?? 'Error',
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
                      '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? '-'}',
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
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('Data not found'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  detail.Verse? verses = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                              Container(
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
                                  child: Text('${index + 1}'),
                                ),
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => Row(
                                      children: [
                                        (controller.audioStatus.value == 'stop')
                                            ? IconButton(
                                                onPressed: () {
                                                  controller.playAudio(
                                                      verses?.audio?.primary);
                                                },
                                                icon: const Icon(
                                                    Icons.play_arrow),
                                              )
                                            : Row(
                                                children: [
                                                  (controller.audioStatus
                                                              .value ==
                                                          'playing')
                                                      ? IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .pauseAudio();
                                                          },
                                                          icon: const Icon(
                                                            Icons.pause,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .resumeAudio();
                                                          },
                                                          icon: const Icon(
                                                            Icons.play_arrow,
                                                          ),
                                                        ),
                                                  IconButton(
                                                    onPressed: () {
                                                      controller.stopAudio();
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
                          verses?.text?.arab ?? 'Error',
                          style: const TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        verses?.text?.transliteration?.en ?? 'Error',
                        style: const TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        verses?.translation?.id ?? 'Error',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
