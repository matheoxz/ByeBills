import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/login.dart';

class LoginPage extends Page {
  final Function() onLogin;
  final Function() onSignUp;

  LoginPage({required this.onLogin, required this.onSignUp});

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => Login(onLogin: onLogin, onSignUp: onSignUp));
  }
}
