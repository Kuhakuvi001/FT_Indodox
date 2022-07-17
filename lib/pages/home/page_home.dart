// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indodox/configs/config_color.dart';
import 'package:indodox/configs/config_image.dart';
import 'package:indodox/configs/config_setting.dart';
import 'package:indodox/models/model_coin.dart';
import 'package:indodox/pages/home/controller_home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorblackv2,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            layoutTop(),
            layoutBody(),
          ],
        )));
    ;
  }

  Widget layoutTop() {
    return AnimatedBuilder(
        animation: controller.animationController!,
        builder: (_, __) {
          return FadeTransition(
              opacity: controller.animationHeader!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - controller.animationHeader!.value), 0.0),
                  child: GetBuilder(
                    init: controller,
                    builder: (_) {
                      return Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(controller.dataselect.name,
                                            style: TextStyle(
                                              color: AppColor.colorwhite,
                                              fontSize:
                                                  AppSetting.sizetextnormal + 3,
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                            NumberFormat("#,###").format(
                                                controller.dataselect.hargaNum),
                                            style: TextStyle(
                                              color: AppColor.colorwhite,
                                              fontSize:
                                                  AppSetting.sizetextnormal + 1,
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Text(
                                            (controller.dataselect.selisih >= 0
                                                    ? "+"
                                                    : "") +
                                                NumberFormat("#,###").format(
                                                    controller
                                                        .dataselect.selisih),
                                            style: TextStyle(
                                              color: (controller
                                                          .dataselect.selisih >=
                                                      0)
                                                  ? AppColor.colorgreen
                                                  : AppColor.colorred,
                                              fontSize:
                                                  AppSetting.sizetextnormal - 5,
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 20),
                                    height: 190,
                                    child: LineChart(LineChartData(
                                      titlesData: FlTitlesData(
                                        show: true,
                                        rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                      ),
                                      borderData: FlBorderData(
                                          show: true,
                                          border: Border.all(
                                              color: const Color(0xff37434d),
                                              width: 1)),
                                      minX: 0,
                                      maxX: controller
                                          .dataselect.hargalist.length
                                          .toDouble(),
                                      minY: controller.dataselect.minharga
                                          .toDouble(),
                                      maxY: controller.dataselect.maxharga
                                          .toDouble(),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots:
                                              controller.dataselect.hargalist,
                                          isCurved: false,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.colorgrayv3,
                                              (controller.dataselect.selisih >=
                                                      0)
                                                  ? Colors.green
                                                  : AppColor.colorredv3
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          barWidth: 3,
                                          isStrokeCapRound: true,
                                          dotData: FlDotData(
                                            show: false,
                                          ),
                                        ),
                                      ],
                                    ))),
                              ]));
                    },
                  )));
        });
  }

  Widget layoutBody() {
    return Expanded(
        child: AnimatedBuilder(
            animation: controller.animationController!,
            builder: (_, __) {
              return FadeTransition(
                  opacity: controller.animationHeader!,
                  child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - controller.animationHeader!.value), 0.0),
                      child: GetBuilder(
                        init: controller,
                        builder: (_) {
                          return Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: ListView.builder(
                                  itemCount: controller.listitem.length,
                                  itemBuilder: (_, pos) {
                                    return layoutItem(controller.listitem[pos]);
                                  }));
                        },
                      )));
            }));
  }

  Widget layoutItem(CoinModel dataitem) {
    return InkWell(
        onTap: () {
          controller.selectCoin(dataitem);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColor.colorgrayv3.withOpacity(0.4)))),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.colorgrayv5.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(AppImage.logo)),
                Padding(padding: EdgeInsets.only(left: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(dataitem.name,
                        style: TextStyle(
                          color: AppColor.colorwhite,
                          fontSize: AppSetting.sizetextnormal + 2,
                          letterSpacing: AppSetting.sizeletterspacing,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("Vol : " + dataitem.volidr,
                        style: TextStyle(
                          color: AppColor.colorwhite.withOpacity(0.6),
                          fontSize: AppSetting.sizetextnormal - 4,
                          letterSpacing: AppSetting.sizeletterspacing,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(NumberFormat("#,###").format(dataitem.hargaNum),
                          style: TextStyle(
                            color: AppColor.colorwhite,
                            fontSize: AppSetting.sizetextnormal + 1,
                            letterSpacing: AppSetting.sizeletterspacing,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          (dataitem.selisih >= 0 ? "+" : "") +
                              NumberFormat("#,###").format(dataitem.selisih),
                          style: TextStyle(
                            color: (dataitem.selisih >= 0)
                                ? AppColor.colorgreen
                                : AppColor.colorred,
                            fontSize: AppSetting.sizetextnormal - 4,
                            letterSpacing: AppSetting.sizeletterspacing,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                )
              ]),
        ));
  }
}
