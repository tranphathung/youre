import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youre/blocs/blocs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Container(
      child: Center(
        child: RaisedButton(
          child: Row(
            children: <Widget>[
              Icon(LineIcons.google),
              Text("Sign In With Google"),
            ],
          ),
          onPressed: () {
            _loginBloc.add(LoginApp());
          },
        ),
      ),
    );
  }
}
