import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
   // double lat = -6.200000.obs;
   // double long = 106.816666.obs;
  // var doubleValue = [-6.200000,106.816666].obs;
  RxDouble lat = 2.464447.obs;
  RxDouble long = 99.058082.obs;
  RxBool isLoading = false.obs;
  // final lat = -6.200000.obs, long = 106.816666.obs;
  // final MapController mapController = MapController();

  Future<bool> checkLocationPermission() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Permission Required", "Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Required", "Location services are denied.");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Required", "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  Future<bool> getCurrentLocation() async{
    isLoading.value = true;
    final hasPermission = await checkLocationPermission();
    if(hasPermission){
      await Geolocator.getCurrentPosition().then((Position position){
        debugPrint(position.toString());
        // location = LatLng(position.latitude, position.longitude) as Rx<LatLng>;
        // doubleValue = [position.latitude,position.longitude];
        lat.value = position.latitude;
        long.value = position.longitude;
        // mapController.move(LatLng(lat.value, long.value),13);
      }).catchError((e){
        debugPrint(e.toString());
      });
    }
    isLoading.value = false;
    return true;
  }
}