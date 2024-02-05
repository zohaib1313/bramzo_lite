import 'package:flutter/cupertino.dart';

import 'common/db_helper/objectbox_class.dart';
import 'my_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorWidget(details.exception);
  };

  runApp(const MyApplication());
}
