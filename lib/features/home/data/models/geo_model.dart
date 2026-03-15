import 'package:hungerbox/features/home/domain/entities/geo.dart';

class GeoModel extends Geo {
  GeoModel({super.lat, super.lng});

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(lat: json['lat'], lng: json['lng']);
  }
}
