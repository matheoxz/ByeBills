import 'package:flutterpoc/src/services/login_services_abstract.dart';
import 'package:flutterpoc/src/services/login_services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ILoginServices>(LoginServices());
}
