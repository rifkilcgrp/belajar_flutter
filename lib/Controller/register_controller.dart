import 'package:belajar_flutter_2/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  final dio = Dio();
  void hidePassword(){
    isVisible.value  = !isVisible.value;
  }

  Future<void> actionRegister() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));

    try{
      var response = await dio.post('${baseUrl}api/user/register',
        data: {
          'email':usernameController.text,
          'name':nameController.text,
          'password':passwordController.text,
        }
      );
      debugPrint(response.data.toString());
      Get.snackbar("Success", "Register Berhasil");
      isLoading.value = false;
      Get.toNamed("/main");
    } on DioException catch(e){
      final code = e.response?.statusCode;
      final body = e.response?.statusMessage;
      debugPrint("Response ${e.response?.data.toString()}");

      if(code == 401){
        Get.snackbar("Register Gagal", body.toString());
      }else{
        Get.snackbar("Gagal", body.toString());
      }
      isLoading.value = false;
    }

  }

}