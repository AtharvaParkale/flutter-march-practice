import 'package:hungerbox/features/home/domain/entities/user.dart';
import 'package:hungerbox/features/home/domain/repositories/home_repository.dart';
import 'package:hungerbox/utils/usecase.dart';

class GetUsersUseCase extends UseCase<List<User>, NoParams> {
  final HomeRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<List<User>> call(params) async {
    return await repository.getUsers();
  }
}
