import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hungerbox/features/home/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDatasource {
  Future<List<UserModel>> getUsers();
}

class HomeRemoteDatSourceImpl extends HomeRemoteDatasource {
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final data = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Content-type': 'application/json'},
      );

      // final data = await rootBundle.loadString("assets/users_data.json");

      final List<dynamic> decodedData = jsonDecode(data.body);

      return decodedData.map((user) => UserModel.fromJson(user)).toList();
    } catch (e) {
      debugPrint("🔴Error :: $e");
      return [];
    }
  }
}
