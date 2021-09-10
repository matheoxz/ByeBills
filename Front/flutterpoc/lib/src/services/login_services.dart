import 'dart:convert';
import 'package:flutterpoc/main.dart';
import 'package:flutterpoc/src/models/user.dart';
import 'package:flutterpoc/src/services/login_services_abstract.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices extends ILoginServices {
  @override
  Future<bool> deleteAccount(String email, String password) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) async {
    String path = 'api/User/login';

    var res = await http.post(Uri.https(url, path),
        body: '{"email":"$email", "password":"$password"}',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": '*'
        });
    if (res.statusCode != 200 && res.statusCode != 204) return false;

    Map<String, dynamic> body = jsonDecode(res.body);
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('jwt', body['token']);
    return true;
  }

  @override
  Future<bool> signup(UserModel user, String password) async {
    var res = await http.post(Uri.https(url, 'api/User/new'), body: '''{
      "email": "${user.email}",
      "username":"${user.username}",
      "name":"${user.name}",
      "password":"$password"
      }''', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": '*'
    });
    if (res.statusCode >= 200 && res.statusCode < 300) {
      login(user.email, password);
      return true;
    }
    return false;
  }
}
