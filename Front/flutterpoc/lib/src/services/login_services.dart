import 'dart:io';

import 'package:flutterpoc/src/models/user.dart';
import 'package:flutterpoc/src/services/login_services_abstract.dart';
import 'package:http/http.dart' as http;

class LoginServices extends ILoginServices {
  @override
  Future<bool> deleteAccount(String email, String password) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) async {
    var res = await http.post(Uri.https('172.30.16.1:44305', 'api/User/login'),
        body: '{"email":"$email", "password":"$password"}',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': 'http://localhost:3000',
          HttpHeaders.allowHeader: '*',
          "Access-Control-Allow-Methods": 'POST, GET, DELETE, PUT, OPTIONS'
        });
    print(res.body);
    return true;
  }

  @override
  Future<bool> signup(UserModel user) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
