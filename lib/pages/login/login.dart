import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        color: primaryColor,
        child: Column(
          children: <Widget>[
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _loginBloc.add(LoginApp());
                },
                child: Container(
                  width: 250.0,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: defaultPadding,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          BrandIcons.google,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Sign in with Google",
                          style: defaultTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
