import 'package:flutterpoc/src/models/user.dart';

abstract class ILoginServices {
  Future<bool> login(String email, String password);
  Future<bool> deleteAccount(String email, String password);
  Future<bool> signup(UserModel user, String password);
}
