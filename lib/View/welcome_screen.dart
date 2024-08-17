import 'package:belajar_flutter_2/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'home-img.jpg'),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Hello",
                          style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Welcome to My App",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Hero(
                            tag: 'login_btn',
                            child: CustomButton(
                              buttonText: "Login",
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                            )),
                        Hero(
                            tag: 'register_btn',
                            child: CustomButton(
                              buttonText: "Sign Up",
                              isOutlined: true,
                              onPressed: () {
                                Get.toNamed("/register");
                              },
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

