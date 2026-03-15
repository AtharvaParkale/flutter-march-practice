import 'package:hungerbox/features/home/domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({super.name, super.catchPhrase, super.bs});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
