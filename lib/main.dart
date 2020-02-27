import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/bloc_delegate.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/blocs/login_bloc/login_state.dart';
import 'package:youre/blocs/popular_bloc/popular_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<PopularBloc>(
          create: (context) =>
              PopularBloc(loginBloc: BlocProvider.of<LoginBloc>(context)),
        ),
        BlocProvider<ChannelBloc>(
          create: (context) =>
              ChannelBloc(loginBloc: BlocProvider.of<LoginBloc>(context)),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomePage(state.user);
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
