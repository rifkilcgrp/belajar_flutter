import 'package:belajar_flutter_2/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString namaView = "Test".obs;
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  final dio = Dio();
  void hidePassword(){
    isVisible.value  = !isVisible.value;
  }

  Future<void> actionLogin() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3));
    try{
      var response = await dio.post('${baseUrl}api/user/login',
        data: {
          'email':usernameController.text,
          'password':passwordController.text,
        }
      );
      debugPrint(response.data.toString());
      Get.snackbar("Success", "Berhasil Login");
      Map data = response.data;
      prefs.setString('access_token', data['access_token']);
      prefs.setString('token_type', data['token_type']);
      prefs.setInt('userId', data['data']['id']);
      prefs.setString('name', data['data']['name']);
      prefs.setString('email', data['data']['email']);
      isLoading.value = false;
      Get.offAllNamed("/main");
    } on DioException catch(e){
      final code = e.response?.statusCode;
      final body = e.response?.statusMessage;
      debugPrint(e.toString());
      if(code == 401){
        Get.snackbar("Login Gagal", body.toString());
      }else{
        Get.snackbar("Gagal", body.toString());
      }
      isLoading.value = false;
    }

  }

  Future<void> actionLogout() async{
    // 500 Server Error
    // try{
    //   var response = await dio.post('${baseUrl}api/logout');
    //   debugPrint(response.data.toString());
      Get.snackbar("Success", "Berhasil Logout");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      prefs.remove('token_type');
      Get.offAllNamed('/welcome');

    // }on DioException catch(e){
    //     final code = e.response?.statusCode;
    //     final body = e.response?.statusMessage;
    //     debugPrint(e.toString());
    //     if(code == 401){
    //       Get.snackbar("Login Gagal", body.toString());
    //     }else{
    //       Get.snackbar("Gagal", body.toString());
    //     }
    //     isLoading.value = false;
    // }
  }

  Future<void> actionGetLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = prefs?.getString("email") ?? "";
    String name = prefs?.getString("name") ?? "";
    usernameController.text = email;
    nameController.text = name;
    namaView.value = name;
  }
}