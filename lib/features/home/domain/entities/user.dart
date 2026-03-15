import 'package:hungerbox/features/home/domain/entities/address.dart';
import 'package:hungerbox/features/home/domain/entities/company.dart';

class User {
  final int id;
  final String name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  User({
    required this.id,
    required this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });
}
