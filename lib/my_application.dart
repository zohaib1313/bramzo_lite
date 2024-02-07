import 'dart:ui';

import 'package:bramzo_lite/common/app_constants.dart';
import 'package:bramzo_lite/common/app_utils.dart';
import 'package:bramzo_lite/views/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext? myContext = navigatorKey.currentState!.context;

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 640),
      builder: (_, __) => GetMaterialApp(
        getPages: appRoutes(),
        // translations  translations: Languages(),
        //   locale: Languages.getCurrentLocale(),
        fallbackLocale: const Locale('en', 'US'),
        title: AppConstants.appName,
        //  initialRoute: HomePage.id,
        localizationsDelegates: const [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate
        ],
        scrollBehavior: MyScrollBehavior(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: GestureDetector(
          onTap: () {
            AppUtils.playTapSound();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const HomePage(),
        ),
      ),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.invertedStylus,
      };
}
