import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Observable for dark mode status

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    update(['theme']);
  }
}
