import 'package:flutterpoc/src/services/bill_service.dart';
import 'package:flutterpoc/src/services/login_services_abstract.dart';
import 'package:flutterpoc/src/services/login_services.dart';
import 'package:flutterpoc/src/services/bill_service_abstract.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ILoginServices>(LoginServices());
  getIt.registerSingleton<IBillService>(BillService());
}
