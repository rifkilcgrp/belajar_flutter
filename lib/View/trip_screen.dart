import 'package:belajar_flutter_2/Controller/trip_controller.dart';
import 'package:belajar_flutter_2/Models/model_trip.dart';
import 'package:belajar_flutter_2/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TripScreen extends StatelessWidget {
  TripController controller = TripController();
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return template(
        "Trip List",
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    // initialCenter: LatLng(-6.200000, 106.816666),
                    initialCenter: LatLng(controller.lat.value, controller.long.value),
                    initialZoom: 9.2),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  const RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        //onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                  PolylineLayer(
                    // polylineCulling: false,
                    polylines: [
                      Polyline(points: controller.route, color: Colors.blue, strokeWidth: 9)
                    ],
                  )
                ]),
            Obx(()=>Visibility(
              visible: controller.selectedId.value > 0,
              child: Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: controller.trips[controller.selectedIndex.value].from,style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          )),
                          const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.arrow_forward),
                              )
                          ),
                          TextSpan(text: controller.trips[controller.selectedIndex.value].to ,style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ))
                        ]
                    ),
                  ),
                ),
              ),
            ),),

            Container(
              height: 300,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  ),
                  border: Border.all()
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Pilihan Harga'),
                    const SizedBox(height: 8,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.trips.length,
                          itemBuilder: (context, index) {
                            ModelTrip data = controller.trips[index];
                            return GestureDetector(
                              onTap: () async {
                                if(await controller.setRouting(data,index)){
                                  mapController.move(LatLng(controller.lat.value, controller.long.value), 10);
                                }
                              },
                              child: Obx(() => Container(
                                  width: Get.width,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: controller.selectedId == data.id ?
                                      Colors.red.withAlpha(30) : Colors.white,
                                      border: Border.all(
                                          color: controller.selectedId == data.id ?
                                          Colors.red.withAlpha(30) :
                                          Colors.white
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(data.name),
                                          Text("${data.from} - ${data.to}"),
                                          const SizedBox(height: 16,),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(data.cost),
                                              const SizedBox(width: 20,),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    style: const TextStyle(color: Colors.black),
                                                    children: [
                                                      const WidgetSpan(
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                            child: Icon(Icons.access_time_outlined),
                                                          )
                                                      ),
                                                      TextSpan(text: data.cost)
                                                    ]
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      // Image.asset(data.image!, height: 70,width: 80,fit: BoxFit.fill,)
                                    ],
                                  )),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
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
        ));
  }
}
