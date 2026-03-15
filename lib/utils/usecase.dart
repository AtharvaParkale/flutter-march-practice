abstract class UseCase<ModelType, Params> {
  Future<ModelType> call(Params params);
}

class NoParams {}
