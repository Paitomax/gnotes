import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gnotes/src/home/home_screen.dart';
import 'package:gnotes/src/login/login_event.dart';
import 'package:gnotes/src/auth_manager.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = LoginBloc();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return _loadingIndicator();
              } else if (state is LoginLoggedInState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ), (Route<dynamic> route) => false);
                });
                return _loadingIndicator();
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "GNotes",
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.purple[900],
                    ),
                  ),
                  SizedBox(height: 80),
                  _signInButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return CircularProgressIndicator();
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.purple[800],
      onPressed: () {
        _bloc.dispatch(LoginButtonPressedEvent());
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.google),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Entrar com Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
