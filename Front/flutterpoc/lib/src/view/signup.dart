import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => {/*navigator*/},
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
                child: _form(context),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _form(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _textFields(),
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

  _textFields() {
    return Flexible(
      child: Form(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            _field(_nameController, _nameValidation, "name", Icons.person),
            _sizedBox(),
            _field(_usernameController, _nameValidation, "username",
                Icons.alternate_email),
            _sizedBox(),
            _field(_emailController, _emailValidation, "email", Icons.email),
            _sizedBox(space: 25),
            _field(_passwordController, _nameValidation, "password",
                Icons.lock_open,
                password: true),
            _sizedBox(),
            _field(_confirmPasswordController, _confirmPasswordValidation,
                "confirm password", Icons.lock,
                password: true)
          ],
        ),
      ),
    );
  }

  TextFormField _field(TextEditingController controller,
      String? Function(String?) validator, String label, IconData icon,
      {bool password = false}) {
    return TextFormField(
      controller: controller,
      validator: validator,
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

  String? _nameValidation(String? value) {
    if (value!.isEmpty) return ('Invalid field');
    return null;
  }

  String? _emailValidation(String? value) {
    if (value!.isEmpty) return ("Invalid name");
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) return "Invalid email";
    return null;
  }

  String? _confirmPasswordValidation(String? value) {
    if (value!.isEmpty) return "Invalid password confirmation";
    if (value != _passwordController.text)
      return "Invalid password confirmation";
    return null;
  }

  _signupButton() {
    return TextButton(
      onPressed: _signup,
      child: Text(
        "signup",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade500,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  _signup() {}

  _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
