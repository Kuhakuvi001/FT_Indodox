// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indodox/configs/config_setting.dart';
import 'package:http/http.dart' as http;
import 'package:indodox/models/model_coin.dart';
import 'package:indodox/pages/home/provider_home.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  List<CoinModel> listitem = [];

  CoinModel dataselect = CoinModel(hargalist: []);

  @override
  void onInit() {
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();

    animationController = AnimationController(
        duration: Duration(milliseconds: AppSetting.timeanimation),
        vsync: this);

    animationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval(0, 1, curve: Curves.fastOutSlowIn)));
    callapiAll();
  }

  @override
  void onReady() {
    super.onReady();
    animationController!.forward();
  }

  void callapiAll() async {
    while (true) {
      try {
        http.Response res = await HomeProvider().getTicketAll();

        if (res.statusCode == 200) {
          var datares = jsonDecode(res.body);
          CoinModel.convertData(listitem, datares);

          if (dataselect.key.isEmpty) dataselect = listitem[0];

          refresh();
        }
      } catch (e) {
        print(e);
      } finally {
        await Future.delayed(Duration(seconds: 5));
      }
    }
  }

  void selectCoin(dataitem) {
    if (dataselect.key != dataitem.key) {
      dataselect = dataitem;
      refresh();
    }
  }
}
