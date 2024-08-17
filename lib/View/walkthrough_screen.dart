import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/model_walkthrough.dart';
import '../utils/custom_widget.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int posisiGambar = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        posisiGambar = pageController.page!.toInt();
      });
    });
  }

  void setPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('spashScreen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: PageView.builder(
          controller: pageController,
          itemCount: walkthoughList.length,
          itemBuilder: (context, index) {
            ModelWalkthrough data = walkthoughList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data.judul!),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(data.gambar!),
                // ImageViewer(url: data.gambar!, height: 100),
                const SizedBox(
                  height: 100,
                ),
                Text(data.deskripsi!),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  pageController.animateToPage(walkthoughList.length,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.ease);
                  debugPrint("Masuk");
                },
                child: const Text("Skip")),
            DotsIndicator(
              dotsCount: walkthoughList.length,
              position: posisiGambar,
            ),
            GestureDetector(
              onTap: () {
                if (posisiGambar < walkthoughList.length - 1) {
                  pageController.nextPage(
                      duration: const Duration(microseconds: 500),
                      curve: Curves.ease);
                } else {
                  setPreference();
                  Get.toNamed('/login');
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.deepPurple,
                  child: iconButton(posisiGambar, walkthoughList.length),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
