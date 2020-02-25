import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/bloc_delegate.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/blocs/login_bloc/login_state.dart';

import 'pages/home/home_page.dart';
import 'pages/login/login.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomePage((state as Authenticated).user);
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
