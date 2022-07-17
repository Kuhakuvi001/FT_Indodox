import 'package:get/get.dart';
import 'package:indodox/pages/splashscreen/controller_splash.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
