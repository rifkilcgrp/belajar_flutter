import 'package:belajar_flutter_2/Controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const TopScreenImage(screenImageName: 'welcome.png'),
                  Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Expanded(
                          flex: 2,
                          child: Obx(() => Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    controller: controller.nameController,
                                    decoration: myDecoration(
                                        "Nama",
                                        const Icon(
                                            Icons.account_circle_rounded)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Harap Isi Nama";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: controller.usernameController,
                                    decoration: myDecoration(
                                        "Email", const Icon(Icons.person)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Harap Isi Email";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: controller.passwordController,
                                    decoration: myDecoration(
                                        "Password", const Icon(Icons.lock),
                                        suffix: IconButton(
                                            onPressed: () {
                                              controller.hidePassword();
                                            },
                                            icon: controller.isVisible.value
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off))),
                                    obscureText: controller.isVisible.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Harap Isi Password";
                                      }
                                      return null;
                                    },
                                  ),
                                  Hero(
                                      tag: 'register_btn',
                                      child: CustomButton(
                                        buttonText: "Register",
                                        onPressed: () {
                                          controller.actionRegister();
                                        },
                                      )),
                                ],
                              )))),
                ],
              ),
            ),
            Obx(() => Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                      color: Colors.white.withOpacity(0.8),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loading",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ],
                      )),
                ))
          ],
        )),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sudah Punya Akun ? "),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/login");
                  },
                  child: const Text(
                    'Masuk Sekarang',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
        )
    );
  }
}
