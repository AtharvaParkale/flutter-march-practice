import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hungerbox/features/home/domain/entities/user.dart';
import 'package:hungerbox/features/home/domain/usecases/get_users_usecase.dart';
import 'package:hungerbox/utils/usecase.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase _getUsersUseCase;

  HomeBloc({required GetUsersUseCase getUsersUseCase})
    : _getUsersUseCase = getUsersUseCase,
      super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetAllUsersEvent>(_onGetAllUsersEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
    on<AddUserEvent>(_onAddUserEvent);
    on<UpdateUser>(_onUpdateUser);
    on<SearchUsersEvent>(_onSearchUsersEvent);
  }

  List<User> users = [];

  Future<void> _onGetAllUsersEvent(
    GetAllUsersEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingState());
    users = await _getUsersUseCase.call(NoParams());

    if (users.isNotEmpty) {
      emit(SuccessState(users: users));
    } else {
      emit(ErrorState());
    }
  }

  FutureOr<void> _onDeleteUserEvent(
    DeleteUserEvent event,
    Emitter<HomeState> emit,
  ) {
    users.removeWhere((user) {
      return user.id == event.id;
    });

    emit(SuccessState(users: users));
  }

  FutureOr<void> _onAddUserEvent(AddUserEvent event, Emitter<HomeState> emit) {
    final User newUser = User(name: event.name, id: event.id);
    users.insert(0, newUser);
    emit(SuccessState(users: users));
  }

  FutureOr<void> _onUpdateUser(UpdateUser event, Emitter<HomeState> emit) {
    final index = users.indexWhere((user) => user.id == event.id);

    if (index != -1) {
      users[index] = User(name: event.name, id: event.id);
    }

    emit(SuccessState(users: List.from(users)));
  }

  FutureOr<void> _onSearchUsersEvent(
    SearchUsersEvent event,
    Emitter<HomeState> emit,
  ) {
    // final filteredUsers = users
    //     .where(
    //       (user) => user.name.toLowerCase().contains(event.query.toLowerCase()),
    //     )
    //     .toList();

    users.sort((a, b) {
      return b.id.compareTo(a.id);
    });

    emit(SuccessState(users: users));
  }
}
