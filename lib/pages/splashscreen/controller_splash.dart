// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indodox/configs/config_route.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  @override
  void onInit() {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();

    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval(0, 1, curve: Curves.fastOutSlowIn)));

    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        waitForSecond();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    animationController!.forward();
  }

  void waitForSecond() async {
    Get.offNamed(AppRoute.home);
  }
}
