// ignore_for_file: prefer_const_constructors

import 'package:http/http.dart';
import 'package:indodox/configs/config_setting.dart';

class HomeProvider {
  Future<Response> getTicketAll() {
    var url = Uri.parse(AppSetting.urlapi + "api/tickers");
    return get(url).timeout(Duration(seconds: AppSetting.timeout));
  }
}
