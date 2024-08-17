import 'dart:ffi';

import 'package:belajar_flutter_2/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delayTime();
  }

  delayTime() async{
    await Future.delayed(const Duration(seconds: 3));
    final preference = await _prefs;
    bool value = preference?.getBool("spashScreen") ?? false;
    String accessToken = preference?.getString("access_token") ?? "";
    String tokenType = preference.getString("token_type") ?? "";
    if(value){
      if(accessToken != "" && tokenType != "") {
        try{
          dio.options.headers['Authorization'] = '${tokenType} ${accessToken}';
          var response = await dio.post('${baseUrl}api/check');
          debugPrint("Response ${response.toString()}");
          if(response.statusCode == 200){
            Get.offAllNamed("/main");
          }
        }on DioException catch(e){
          Get.offAllNamed('/welcome');

        }
      }else{
        Get.offAllNamed('/welcome');
      }
    }else{
      Get.offAllNamed('/walkthrough');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset(
                'assets/img/loading-image.jpg',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Selamat Datang",style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    )),
                    CircularProgressIndicator(
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
