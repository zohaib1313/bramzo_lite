import 'package:bramzo_lite/views/home/controllers/home_page_controller.dart';
import 'package:bramzo_lite/views/home/home_page.dart';
import 'package:get/get.dart';

List<GetPage> appRoutes() {
  return [
    ///...............put dependencies not being used as lazy .................../////
    GetPage(
      name: HomePage.id,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(
        () {
          Get.put(() => HomePageController());
        },
      ),
    ),
  ];
}
