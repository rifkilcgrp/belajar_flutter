import 'package:belajar_flutter_2/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../Controller/map_search_controller.dart';
class MapScreen extends StatelessWidget {

  MapSearchController controller = MapSearchController();
  final MapController mapController = MapController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return template(
      "Maps",
            SingleChildScrollView(
                child: Obx(()=>Stack(
                  children: [
                    Column(
                      children:[
                        Padding(
                          padding:const EdgeInsets.all(10),
                          child:
                          Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,

                            child:  Column(
                              children: [
                                TextFormField(
                                  controller: controller.startInput,
                                  decoration: myDecoration("Starting Post Code", const Icon(Icons.pin_drop)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Value Wajib Diisi";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10,),
                                TextFormField(
                                  controller: controller.endInput,
                                  decoration: myDecoration("End Post Code", const Icon(Icons.pin_drop)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Value Wajib Diisi";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 5,),
                                Hero(
                                    tag: 'cari_btn',
                                    child: CustomButton(
                                      width: 100,
                                      fontSize: 16,
                                      buttonText: "Search",
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if(await controller.searchData()) {
                                            mapController.move(LatLng(controller.lat.value, controller.long.value), 10);
                                          }
                                        }
                                      },
                                    )),
                              ],
                            ),
                          ),

                        ),
                        SizedBox(
                          height: Get.height,
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: LatLng(controller.lat.value,controller.long.value),
                              initialZoom: 13,
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
                              PolylineLayer(
                                // polylineCulling: false,
                                polylines: [
                                  Polyline(points: controller.route, color: Colors.blue, strokeWidth: 9)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Visibility(
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
                    )
                  ],
                )
              ))
    );
  }
}
