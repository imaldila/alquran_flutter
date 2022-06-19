import 'package:alquran_flutter/app/data/models/juz.dart' as juz;
import 'package:alquran_flutter/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/constant.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  DetailJuzView({Key? key}) : super(key: key);

  final juz.Juz detailJuz = Get.arguments['juz'];
  final List<Surah> allSurahInThisJuz = Get.arguments['surah'];

  @override
  Widget build(BuildContext context) {
    // for (var element in allSurahInThisJuz) {
    //   print(element.name!.transliteration!.id);
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          juz.Verses? verses = detailJuz.verses![index];

          if (index != 0) {
            if (verses.number?.inSurah == 1) {
              controller.index++;
            }
          }
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
                              child: Text('${verses.number?.inSurah ?? ''}'),
                            ),
                          ),
                          Text(
                            allSurahInThisJuz[controller.index]
                                    .name
                                    ?.transliteration
                                    ?.id ??
                                '',
                            style: const TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              print('play');
                            },
                            icon: const Icon(Icons.play_arrow),
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
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  verses.text?.arab ?? 'Error',
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                verses.text?.transliteration?.en ?? 'Error',
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                verses.translation?.id ?? 'Error',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          );
        },
      ),
    );
  }
}
