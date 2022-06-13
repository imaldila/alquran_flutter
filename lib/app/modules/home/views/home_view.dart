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
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Data not found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Surah surah = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${surah.number}'),
                ),
                title: Text(surah.name?.transliteration?.id ?? 'Error'),
                subtitle: Text(
                    '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? '-'}'),
                trailing: Text(surah.name?.short ?? '-'),
              );
            },
          );
        },
      ),
    );
  }
}
