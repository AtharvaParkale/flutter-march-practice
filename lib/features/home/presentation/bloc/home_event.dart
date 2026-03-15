part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetAllUsersEvent implements HomeEvent {}

class DeleteUserEvent implements HomeEvent {
  final int id;

  DeleteUserEvent({required this.id});
}

class AddUserEvent implements HomeEvent {
  final String name;
  final int id;

  AddUserEvent({required this.id, required this.name});
}

class UpdateUser implements HomeEvent {
  final String name;
  final int id;

  UpdateUser({required this.id, required this.name});
}
