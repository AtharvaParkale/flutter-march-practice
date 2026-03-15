import 'package:hungerbox/features/home/data/models/geo_model.dart';
import 'package:hungerbox/features/home/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    super.city,
    super.geo,
    super.suite,
    super.street,
    super.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'],
      street: json['street'],
      suite: json['zipcode'],
      geo: GeoModel.fromJson(json['geo']),
    );
  }
}
