import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungerbox/features/home/presentation/bloc/home_bloc.dart';
import 'package:hungerbox/features/profile/screen_two.dart';
import 'package:hungerbox/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(GetAllUsersEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        print("Demo");
        context.read<HomeBloc>().add(LoadMoreUsers());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now the topmost route.
    print('didPush');
  }

  @override
  void didPushNext() {
    // Route was pushed onto navigator and is now the topmost route.
    print('didPushNext');
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print('didPopNext');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 20),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            buildWhen: (prev, curr) =>
                curr is LoadingState ||
                curr is SuccessState ||
                curr is ErrorState,
            builder: (context, state) {
              if (state is LoadingState) {
                return Text("Loading");
              } else if (state is SuccessState) {
                return Column(
                  children: [
                    FormWidget(),
                    SizedBox(height: 20),
                    Card(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.users.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return ListTile(
                            leading: Text("${state.users[index].id}"),
                            title: Text(state.users[index].name),
                            onTap: () {
                              context.read<HomeBloc>().add(
                                DeleteUserEvent(id: state.users[index].id),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              } else {
                return Text("Error");
              }
            },
          ),
        ),
      ),
      // body: BlocConsumer<HomeBloc, HomeState>(
      //   listener: (context, state) {},
      //   buildWhen: (prev, curr) =>
      //   curr is LoadingState || curr is SuccessState || curr is ErrorState,
      //   builder: (context, state) {
      //     if (state is LoadingState) {
      //       return Text("Loading");
      //     } else if (state is SuccessState) {
      //       return ListView.builder(
      //         controller: _scrollController,
      //         // shrinkWrap: true,
      //         // physics: NeverScrollableScrollPhysics(),
      //         itemCount: state.users.length,
      //         itemBuilder: (BuildContext buildContext, int index) {
      //           return ListTile(
      //             leading: Text("${state.users[index].id}"),
      //             title: Text(state.users[index].name),
      //             onTap: () {
      //               context.read<HomeBloc>().add(
      //                 DeleteUserEvent(id: state.users[index].id),
      //               );
      //             },
      //           );
      //         },
      //       );
      //     } else {
      //       return Text("Error");
      //     }
      //   },
      // ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final nameController = TextEditingController(text: "");
  final idController = TextEditingController(text: "");
  final searchQuery = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("User Form"),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        searchQuery.text = val;

                        context.read<HomeBloc>().add(
                          SearchUsersEvent(query: searchQuery.text),
                        );
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        nameController.text = val;
                      });
                    },
                    validator: (value) {
                      if (value == null) return "Name filed cannot be empty !";
                      if (value.isEmpty) {
                        return "Name filed cannot be empty !";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        idController.text = val;
                      });
                    },
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null) return "ID filed cannot be empty !";
                      if (value.isEmpty) {
                        return "ID filed cannot be empty !";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<HomeBloc>().add(
                  AddUserEvent(
                    id: int.tryParse(idController.text) ?? 1,
                    name: nameController.text,
                  ),
                );
              }
            },
            child: Text("Click"),
          ),
          OutlinedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Text("demo");
                },
              );

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return ScreenTwo();
              //     },
              //   ),
              // );
              if (_formKey.currentState!.validate()) {
                context.read<HomeBloc>().add(
                  UpdateUser(
                    id: int.tryParse(idController.text) ?? 1,
                    name: nameController.text,
                  ),
                );
              }
            },
            child: Text("Update"),
          ),

          OutlinedButton(
            onPressed: () {
              context.read<HomeBloc>().add(SearchUsersEvent(query: ""));
            },
            child: Text("Sort"),
          ),
          OutlinedButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) => const ProfileScreen(),
              //   ),
              // );

              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ScreenTwo(),
                ),
              );
            },
            child: Text("Navigate"),
          ),
        ],
      ),
    );
  }
}
