import 'package:flutter/material.dart';

class Configurations extends StatelessWidget {
  final Function() onBack;
  final Function() onLogOut;
  final Function() onDeleteAccount;

  Configurations(
      {required this.onBack,
      required this.onLogOut,
      required this.onDeleteAccount,
      Key? key})
      : super(key: key);

  String _name = "Jauzin";
  String _username = "jaum12";
  String _email = "jau@unesp.br";
  late MediaQueryData media;

  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context);

    return (media.size.width < media.size.height)
        ? _verticalScreen()
        : _horizontalScreen();
  }

  Widget _verticalScreen() {
    return Scaffold(
      appBar: AppBar(
          title: const Text("configurations"),
          backgroundColor: Colors.teal.shade300,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25, right: 25),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: media.size.height * 0.4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _configRow(_name, Icons.perm_identity),
                    _sizedBox(),
                    _configRow(_username, Icons.alternate_email),
                    _sizedBox(),
                    _configRow(_email, Icons.mail),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              child: Container(
                child: Column(
                  children: [
                    _sizedBox(space: media.size.height * 0.2),
                    _logOutButton(),
                    _deleteAccountButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _horizontalScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("configurations"),
        backgroundColor: Colors.teal.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: media.size.height * 0.5,
                    maxWidth: media.size.width * 0.5,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _configRow(_name, Icons.perm_identity),
                        _sizedBox(),
                        _configRow(_username, Icons.alternate_email),
                        _sizedBox(),
                        _configRow(_email, Icons.mail),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: media.size.width * 0.3,
                  ),
                  child: Column(
                    children: [
                      _sizedBox(space: media.size.height * 0.15),
                      _logOutButton(),
                      _deleteAccountButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _configRow(String param, IconData? icontype) {
    if (media.size.width < media.size.height) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                icontype,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                param,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: media.size.height / 10,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                icontype,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                param,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _logOutButton() {
    return RawMaterialButton(
      fillColor: Colors.amberAccent,
      splashColor: Colors.amberAccent.shade100,
      onPressed: onLogOut,
      shape: StadiumBorder(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _deleteAccountButton() {
    return RawMaterialButton(
      fillColor: Colors.red.shade400,
      splashColor: Colors.red.shade300,
      onPressed: onDeleteAccount,
      shape: StadiumBorder(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "delete account",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
