import 'package:belajar_flutter_2/Controller/login_controller.dart';
import 'package:belajar_flutter_2/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    controller.actionGetLogin();
    return template(
        "Profile",
        actionBtn: <Widget>[
          IconButton(
            onPressed: () {
              controller.actionLogout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
        SafeArea(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Column(
                children: [
                  Obx(
                    () => Row(children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.orange,
                        child: Text(
                          "${controller.namaView.value[0].toUpperCase()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.namaView.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const  Text(
                      "User Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: controller.nameController,
                      decoration:
                      const InputDecoration(hintText: "Nama", labelText: "Nama"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: controller.usernameController,
                      decoration: const InputDecoration(
                          hintText: "Email", labelText: "Email"),
                    ),
                  ],
                ))
          ],
        )));
  }
}
