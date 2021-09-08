import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/src/view/signup.dart';

class SignUpPage extends Page {
  final Function() onPop;
  final Function() onSignUp;
  SignUpPage({required this.onPop, required this.onSignUp});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => SignUp(
              onPop: onPop,
              onSignUp: onSignUp,
            ));
  }
}
