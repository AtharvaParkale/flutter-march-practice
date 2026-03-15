import 'package:hungerbox/features/home/data/models/address_model.dart';
import 'package:hungerbox/features/home/data/models/company_model.dart';
import 'package:hungerbox/features/home/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    super.username,
    super.email,
    super.address,
    super.phone,
    super.website,
    super.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyModel.fromJson(json['address']),
    );
  }
}
