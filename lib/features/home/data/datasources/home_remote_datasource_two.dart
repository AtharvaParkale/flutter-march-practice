import 'dart:convert';

import 'package:hungerbox/features/home/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDatasourceTwo {
  Future<List<UserModel>> getUsers();
}

class HomeRemoteDatasourceTwoImpl implements HomeRemoteDatasourceTwo {
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final data = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        headers: {'Content-Type': 'application/json'},
      );

      final List<dynamic> decodedJson = jsonDecode(data.body);

      return decodedJson.map((user) => UserModel.fromJson(user)).toList();
    } catch (e) {
      return [];
    }
  }
}
