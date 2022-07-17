import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indodox/configs/config_color.dart';
import 'package:indodox/configs/config_font.dart';
import 'package:indodox/configs/config_route.dart';
import 'package:indodox/pages/home/binding_home.dart';
import 'package:indodox/pages/home/page_home.dart';
import 'package:indodox/pages/splashscreen/binding_splash.dart';
import 'package:indodox/pages/splashscreen/page_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.colorblackv2));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: AppFont.fontregular,
      ),
      initialRoute: AppRoute.splashcreen,
      getPages: [
        GetPage(
          name: AppRoute.splashcreen,
          page: () => SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: AppRoute.home,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
