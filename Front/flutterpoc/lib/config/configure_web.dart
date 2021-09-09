import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutterpoc/main.dart';

void configureApp() {
  url = 'localhost:5001';
  setUrlStrategy(PathUrlStrategy());
}
