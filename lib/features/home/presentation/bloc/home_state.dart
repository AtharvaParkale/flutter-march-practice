part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class SuccessState extends HomeState {
  final List<User> users;

  SuccessState({required this.users});
}

class ErrorState extends HomeState {}
