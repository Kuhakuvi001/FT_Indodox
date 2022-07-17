import 'package:get/get.dart';
import 'package:indodox/pages/home/controller_home.dart';
import 'package:indodox/pages/splashscreen/controller_splash.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
