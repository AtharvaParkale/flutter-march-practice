import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungerbox/features/home/data/datasources/home_remote_datasource.dart';
import 'package:hungerbox/features/home/data/repositories/home_repository_impl.dart';
import 'package:hungerbox/features/home/domain/usecases/get_users_usecase.dart';
import 'package:hungerbox/features/home/presentation/bloc/home_bloc.dart';
import 'package:hungerbox/features/home/presentation/home_screen.dart';
import 'package:hungerbox/features/profile/profile_screen.dart';
import 'package:hungerbox/features/profile/screen_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: BlocProvider(
        create: (BuildContext context) {
          return HomeBloc(
            getUsersUseCase: GetUsersUseCase(
              HomeRepositoryImpl(HomeRemoteDatSourceImpl()),
            ),
          ); // replace with your bloc
        },
        // child: HomeScreen(), // replace with your page
        child: ScreenTwo(),
      ),
    );
  }
}
