import 'package:flutter/cupertino.dart';

import 'my_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorWidget(details.exception);
  };

  runApp(const MyApplication());
}
