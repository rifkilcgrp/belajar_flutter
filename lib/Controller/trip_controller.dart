import 'package:belajar_flutter_2/Models/model_trip.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
class TripController extends GetxController{
  var trips = listTrip().obs;
  RxInt selectedId = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxDouble lat = 2.464447.obs;
  RxDouble long = 99.058082.obs;
  RxList<LatLng> route = [LatLng(2.464447, 99.058082)].obs;

  final dio = Dio();


  Future<bool> setRouting(ModelTrip data,int index) async{
    selectedId.value = data.id;
    selectedIndex.value = index;
    isLoading.value = true;


    route.clear();
    List<Location> startValue = await locationFromAddress(data.from);
    List<Location> endValue = await locationFromAddress(data.to);

    var v1 = startValue[0].latitude;
    var v2 = startValue[0].longitude;
    var v3 = endValue[0].latitude;
    var v4 = endValue[0].longitude;

    try {
      var response = await dio.get('http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
      Map data = response.data;
      var coordinate = data['routes'][0]['geometry']['coordinates'];
      for(int i=0; i < coordinate.length; i++){
        String a = coordinate[i].toString();
        a = a.replaceAll("[", "");
        a = a.replaceAll("]", "");
        var split = a.split(',');
        double lat1 = double.parse(split[1]);
        double long1 = double.parse(split[0]);
        route.add(LatLng(lat1, long1));

        if(i == 0){
          lat.value = lat1;
          long.value = long1;
        }
      }
      debugPrint(route.toString() );
      isLoading.value = false;

    }on DioException catch(e){
      final code = e.response?.statusCode;
      final body = e.response?.statusMessage;
      debugPrint(e.toString());
      if(code == 401){
        Get.snackbar("Load Data Gagal", body.toString());
      }else{
        Get.snackbar("Load Data Gagal", body.toString());
      }
      isLoading.value = false;
    }

    isLoading.value = false;

    return true;
  }
}