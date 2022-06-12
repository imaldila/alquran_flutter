import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Al-Quran Apps',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Sesibuk itukah kamu \n sampai belum membaca Al-Quran ?',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset(
                'assets/lotties/animasi_quran.json',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Let Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
