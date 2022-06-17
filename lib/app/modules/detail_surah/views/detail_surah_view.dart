import 'package:alquran_flutter/app/data/models/detail_surah.dart' as detail;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    surah.name?.transliteration?.id ?? 'Error',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '( ${surah.name?.translation?.id ?? 'Error'} )',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? '-'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
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
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
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
                      Text(
                        verses?.text?.arab ?? 'Error',
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        verses?.text?.transliteration?.en ?? 'Error',
                        style: const TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        verses?.translation?.id ?? 'Error',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
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
