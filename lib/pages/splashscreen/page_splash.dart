// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indodox/configs/config_image.dart';
import 'package:indodox/pages/splashscreen/controller_splash.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AnimatedBuilder(
                animation: controller.animationController!,
                builder: (_, __) {
                  return FadeTransition(
                      opacity: controller.animationHeader!,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0,
                              30 * (1.0 - controller.animationHeader!.value),
                              0.0),
                          child: Center(
                            child: Image.asset(
                              AppImage.logo,
                              width: 250,
                            ),
                          )));
                })));
  }
}
