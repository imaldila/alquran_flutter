import 'package:alquran_flutter/app/data/models/detail_surah.dart' as detail;
import 'package:alquran_flutter/app/routes/app_pages.dart';
import 'package:alquran_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Al Quran Apps'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.isDarkMode
                ? Get.changeTheme(themeLight)
                : Get.changeTheme(themeDark);
            controller.isDark.toggle();
          },
          child: Obx(
            () => Icon(Icons.color_lens,
                color: controller.isDark.isTrue ? appPurple : appWhite),
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assalamu\'alikum',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
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
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Get.toNamed(Routes.LAST_READ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: -50,
                            child: Opacity(
                              opacity: 0.5,
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  'assets/images/img_quran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.menu_book_outlined,
                                      color: appWhite,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Last Read',
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                const Text(
                                  'Al Fatihah',
                                  style:
                                      TextStyle(fontSize: 16, color: appWhite),
                                ),
                                const Text(
                                  'Ayat No. 1',
                                  style: TextStyle(color: appWhite),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(
                      text: 'Surah',
                    ),
                    Tab(
                      text: 'Juz',
                    ),
                    Tab(
                      text: 'Bookmark',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder<List<Surah>>(
                        future: controller.getAllSurah(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Data not found'));
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];

                              return ListTile(
                                onTap: () => Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah),
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_octagonal.png'),
                                        fit: BoxFit.contain),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        '${surah.number}',
                                        style: TextStyle(
                                          color: controller.isDark.isTrue
                                              ? appWhite
                                              : appPurpleDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Obx(
                                  () => Text(
                                    surah.name?.transliteration?.id ?? 'Error',
                                    style: TextStyle(
                                      color: controller.isDark.isTrue
                                          ? appWhite
                                          : appPurpleDark,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? '-'}',
                                  style: const TextStyle(color: appPurpleLight),
                                ),
                                trailing: Text(
                                  surah.name?.short ?? '-',
                                  style: const TextStyle(color: appPurpleDark),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: controller.getAllJuz(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Data not found'));
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> dataMapPerJuz =
                                  snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(
                                  Routes.DETAIL_JUZ,
                                  arguments: dataMapPerJuz,
                                ),
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_octagonal.png'),
                                        fit: BoxFit.contain),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: controller.isDark.isTrue
                                              ? appWhite
                                              : appPurpleDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Obx(
                                  () => Text(
                                    'Juz ${index + 1}',
                                    style: TextStyle(
                                      color: controller.isDark.isTrue
                                          ? appWhite
                                          : appPurpleDark,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  '${dataMapPerJuz['start']['surah']} ${(dataMapPerJuz['start']['ayat'] as detail.Verse).number!.inSurah}  | ${dataMapPerJuz['end']['surah']} ${(dataMapPerJuz['end']['ayat'] as detail.Verse).number!.inSurah}',
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // FutureBuilder<List<juz.Juz>>(
                      //   future: controller.getAllJuz(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }
                      //     if (!snapshot.hasData) {
                      //       return const Center(child: Text('Data not found'));
                      //     }

                      //     return ListView.builder(
                      //       itemCount: snapshot.data!.length,
                      //       itemBuilder: (context, index) {
                      //         juz.Juz detailJuz = snapshot.data![index];

                      //         String nameStart =
                      //             detailJuz.juzStartInfo?.split(' - ').first ??
                      //                 '';
                      //         String nameEnd =
                      //             detailJuz.juzEndInfo?.split(' - ').first ??
                      //                 '';

                      //         List<Surah> rawAllSurahInJuz = [];
                      //         List<Surah> allSurahInJuz = [];

                      //         for (Surah item in controller.surah) {
                      //           rawAllSurahInJuz.add(item);
                      //           if (item.name!.transliteration!.id == nameEnd) {
                      //             break;
                      //           }
                      //         }
                      //         for (Surah item
                      //             in rawAllSurahInJuz.reversed.toList()) {
                      //           allSurahInJuz.add(item);
                      //           if (item.name!.transliteration!.id ==
                      //               nameStart) {
                      //             break;
                      //           }
                      //         }

                      //         return ListTile(
                      //           onTap: () => Get.toNamed(
                      //             Routes.DETAIL_JUZ,
                      //             arguments: {
                      //               'juz': detailJuz,
                      //               'surah': allSurahInJuz.reversed.toList(),
                      //             },
                      //           ),
                      //           leading: Container(
                      //             height: 40,
                      //             width: 40,
                      //             decoration: const BoxDecoration(
                      //               image: DecorationImage(
                      //                   image: AssetImage(
                      //                       'assets/images/img_octagonal.png'),
                      //                   fit: BoxFit.contain),
                      //             ),
                      //             child: Center(
                      //               child: Obx(
                      //                 () => Text(
                      //                   '${detailJuz.juz}',
                      //                   style: TextStyle(
                      //                     color: controller.isDark.isTrue
                      //                         ? appWhite
                      //                         : appPurpleDark,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           title: Obx(
                      //             () => Text(
                      //               'Juz ${detailJuz.juz}',
                      //               style: TextStyle(
                      //                 color: controller.isDark.isTrue
                      //                     ? appWhite
                      //                     : appPurpleDark,
                      //               ),
                      //             ),
                      //           ),
                      //           subtitle: Text(
                      //               '${detailJuz.juzStartInfo} | ${detailJuz.juzEndInfo}'),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),

                      const Center(
                        child: Text('Bookmark'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
