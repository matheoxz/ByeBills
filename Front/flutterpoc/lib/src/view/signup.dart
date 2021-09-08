import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

class SignUp extends StatefulWidget {
  final Function() onPop;
  final Function() onSignUp;

  SignUp({Key? key, required this.onPop, required this.onSignUp})
      : super(key: key);

  @override
  _SignUpState createState() => _SignUpState(onPop: onPop, onSignUp: onSignUp);
}

class _SignUpState extends State<SignUp> {
  final Function() onPop;
  final Function() onSignUp;

  _SignUpState({required this.onPop, required this.onSignUp});

  final _nameController = TextEditingController();

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  ButtonState signupButtonState = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  _appBar() {
    return AppBar(
      title: Text("Signup"),
      centerTitle: true,
      backgroundColor: Colors.teal.shade300,
      leading: IconButton(
        onPressed: widget.onPop,
        icon: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  _body(context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: _page(context),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _page(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _form(),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _signupButton(),
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();

  _form() {
    return Form(
      key: _formKey,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          _field(_nameController, _fieldValidation, "name", Icons.person),
          _sizedBox(),
          _field(_usernameController, _fieldValidation, "username",
              Icons.alternate_email),
          _sizedBox(),
          _field(_emailController, _emailValidation, "email", Icons.email),
          _sizedBox(space: 25),
          _field(_passwordController, _fieldValidation, "password",
              Icons.lock_open,
              password: true),
          _sizedBox(),
          _field(_confirmPasswordController, _confirmPasswordValidation,
              "confirm password", Icons.lock,
              password: true)
        ],
      ),
    );
  }

  TextFormField _field(TextEditingController controller,
      String? Function(String, String?) validator, String label, IconData icon,
      {bool password = false}) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(label, value),
      keyboardType: TextInputType.text,
      obscureText: password,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(icon)),
    );
  }

  String? _fieldValidation(String fieldName, String? value) {
    if (value!.isEmpty) return ('Invalid $fieldName');
    return null;
  }

  String? _emailValidation(String fieldName, String? value) {
    if (value!.isEmpty) return ("Invalid email");
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) return "Invalid email";
    return null;
  }

  String? _confirmPasswordValidation(String fieldName, String? value) {
    if (value!.isEmpty) return "Invalid password confirmation";
    if (value != _passwordController.text)
      return "Invalid password confirmation";
    return null;
  }

  _signupButton() {
    return ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          "signup",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ButtonState.loading: Text(
          "",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ButtonState.fail: Text(
          "fail",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ButtonState.success: Text(
          "success",
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.teal.shade500,
        ButtonState.loading: Colors.teal.shade100,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: () async => await _signup(),
      state: signupButtonState,
      progressIndicatorAligment: MainAxisAlignment.center,
      radius: 45,
    );
  }

  _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          signupButtonState = ButtonState.loading;
        });
        setState(() {
          signupButtonState = ButtonState.success;
        });
        onPop();
      } catch (e) {
        setState(() {
          signupButtonState = ButtonState.fail;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.amber,
        content: Text("invalid fields, please fill it correctly"),
        elevation: 5.0,
      ));
    }
  }

  _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
