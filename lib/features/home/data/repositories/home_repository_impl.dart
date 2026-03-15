import 'package:hungerbox/features/home/data/datasources/home_remote_datasource.dart';
import 'package:hungerbox/features/home/domain/entities/user.dart';
import 'package:hungerbox/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<User>> getUsers() async {
    final users = await remoteDatasource.getUsers();

    return users.map((user) => user as User).toList();
  }
}
