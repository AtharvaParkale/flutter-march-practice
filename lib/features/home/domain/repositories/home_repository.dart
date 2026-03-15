import 'package:hungerbox/features/home/domain/entities/user.dart';

abstract interface class HomeRepository {
  Future<List<User>> getUsers();
}
