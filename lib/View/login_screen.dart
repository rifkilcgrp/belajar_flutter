import 'package:belajar_flutter_2/Controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());
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
                        child: Obx(
                                () => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: controller.usernameController,
                              decoration: myDecoration(
                                  "Email", const Icon(Icons.person)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Harap Isi Email atau No Hp";
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
                                          : const Icon(Icons.visibility_off))),
                              obscureText: controller.isVisible.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Harap Isi Password";
                                }
                                return null;
                              },
                            ),
                            Hero(
                                tag: 'login_btn',
                                child: CustomButton(
                                  buttonText: "Login",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      debugPrint("Valid");
                                      controller.actionLogin();
                                    }
                                  },
                                )),
                          ],
                        )))),
              ],
            ),
          ),
          Obx(()=> Visibility(
            visible: controller.isLoading.value,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ],
              )
            ),
          ) )
        ],
      )),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum Punya Akun ? "),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/register");
                  },
                  child: const Text(
                    'Daftar Sekarang',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
        )
    );
  }
}
