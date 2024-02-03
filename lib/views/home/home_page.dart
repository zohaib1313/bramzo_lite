import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/styles.dart';
import 'controllers/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);
  static const id = '/homePage';

  @override
  Widget build(BuildContext context) {
    return GetX<HomePageController>(
      init: HomePageController(),
      initState: (state) {},
      builder: (controller) {
        controller.isLoading.value;
        return Scaffold(
          backgroundColor: AppColors.primaryBlueColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(),
            ),
          ),
        );
      },
    );
  }
}
