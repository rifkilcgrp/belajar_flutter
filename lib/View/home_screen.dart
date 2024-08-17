import 'package:belajar_flutter_2/Controller/home_controller.dart';
import 'package:belajar_flutter_2/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    final MapController mapController = MapController();
    return template(
        "Home",
        SingleChildScrollView(
          child: Container(
            color: Colors.white,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: const Text(
                    "Selamat Datang",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.loose,
                  children: [
                    Container(
                      alignment: const Alignment(1, 1),
                      // decoration: const BoxDecoration(
                      //   borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(10),
                      //     topLeft: Radius.circular(10),
                      //   ),
                      // ),
                      height: MediaQuery.of(context).size.height,
                      child: Obx(()=> FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(controller.lat.value,controller.long.value),
                          initialZoom: 9.2,
                        ),
                        children: [
                          TileLayer(
                            // Display map tiles from any source
                            urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                            userAgentPackageName: 'com.example.app',
                            maxNativeZoom:
                            25, // Scale tiles when the server doesn't support higher zoom levels
                          ),
                          const RichAttributionWidget(
                            // Include a stylish prebuilt attribution widget that meets all requirments
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                              ),
                            ],
                          ),
                          MarkerLayer(
                              markers: [
                                Marker(
                                    point: LatLng(controller.lat.value,controller.long.value),
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 40,
                                    )
                                )
                              ]
                          )
                        ],
                      ),
                      )
                    ),
                    Positioned(
                      top: 20,
                        child: TextButton(
                            onPressed: () async {
                                if(await controller.getCurrentLocation()){
                                  mapController.move(LatLng(controller.lat.value, controller.long.value), 13);
                                };
                            },
                            child: Text("Get Current Location"),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                            )
                        )
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
                ),
              ],
            ),
          ),
        ));
  }
}
