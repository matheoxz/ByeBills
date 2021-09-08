import 'package:flutter/material.dart';
import 'package:flutterpoc/config/get_it_registrations.dart';
import 'package:flutterpoc/src/misc/animated_color_text.dart';
import 'package:flutterpoc/src/services/login_services_abstract.dart';

class Login extends StatelessWidget {
  final Function() onSignUp;
  final Function() onLogin;
  late ILoginServices _loginServices;

  Login({
    Key? key,
    required this.onLogin,
    required this.onSignUp,
  }) : super(key: key) {
    _loginServices = getIt<ILoginServices>();
  }
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(child: _title(context)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: _form(context),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.height / 2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _title(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSize = width < height ? height / 7 : width / 10;
    return AnimatedColorText(
      text: "BYE\nBILLS",
      tween: ColorTween(begin: Colors.amber, end: Colors.teal),
      fontSize: fontSize,
    );
  }

  _form(BuildContext context) {
    return Form(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          _sizedBox(),
          emailField(),
          _sizedBox(),
          passwordField(),
          _sizedBox(),
          loginButton(),
          _sizedBox(),
          signupButton(),
          _sizedBox(),
          forgotPasswordButton(),
        ],
      ),
    );
  }

  emailField() {
    return TextFormField(
      controller: _emailController,
      validator: _emailValidation,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "email",
          labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  passwordField() {
    return TextFormField(
      controller: _passwordController,
      validator: _passwordValidation,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "password",
          labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  loginButton() {
    return TextButton(
      onPressed: _login,
      child: Text(
        "login",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade500,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  signupButton() {
    return TextButton(
      onPressed: onSignUp,
      child: Text(
        "sign up",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade300,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  forgotPasswordButton() {
    return TextButton(
      onPressed: _forgotPassword,
      child: Text(
        "forgot password",
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            decoration: TextDecoration.underline),
      ),
    );
  }

  String? _emailValidation(String? text) {
    if (text!.isEmpty) return "Invalid email";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text)) return "Invalid email";
    return null;
  }

  String? _passwordValidation(String? text) {
    if (text!.isEmpty) return "Invalid password";
    return null;
  }

  _forgotPassword() {}

  _login() {
    _loginServices.login(_emailController.text, _passwordController.text);
    onLogin();
  }

  _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
