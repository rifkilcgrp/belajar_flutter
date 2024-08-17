import 'package:geocoding/geocoding.dart';

class ModelTrip {
  int id;
  String name;
  String from;
  String to;
  String? image;
  String cost;

  ModelTrip({required this.id,required this.name,required this.from, required this.to, required this.cost, this.image,});
}

List<ModelTrip> listTrip() {
  List<ModelTrip> list = [];
  list.add(ModelTrip(id:1,name: "Trip 1", from: "Teluk Pucung", to: "Babelan", cost: "Rp.10,000"));
  list.add(ModelTrip(id:2,name: "Trip 2", from: "Teluk Pucung", to: "Pulo Gadung", cost: "Rp.100,000"));
  list.add(ModelTrip(id:3,name: "Trip 3", from: "Teluk Pucung", to: "Pasar Senen", cost: "Rp.100,000"));
  return list;
}
