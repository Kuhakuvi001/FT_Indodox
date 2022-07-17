import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class CoinModel {
  String key;
  String name;

  String volidr;
  int hargaNum;
  int hargaAwal;
  int maxharga;
  int minharga;
  int selisih;
  List<FlSpot> hargalist;

  CoinModel({
    this.key = "",
    this.name = "",
    this.volidr = "",
    this.hargaNum = 0,
    this.hargaAwal = 0,
    this.maxharga = 0,
    this.minharga = 0,
    this.selisih = 0,
    required this.hargalist,
  });

  static void convertData(List<CoinModel> listitem, Map datares) {
    var list = datares['tickers']
        .entries
        .map((item) => ({item.key: item.value}))
        .toList();

    for (Map item in list) {
      try {
        String key = item.keys.first;
        var data = item[key];

        var last = data['last'].toString();
        var volidr = data['vol_idr'].toString();

        var harganum = int.tryParse(last) ?? 0;
        var vol = NumberFormat("#,###").format(int.tryParse(volidr) ?? 0);

        var pos = listitem
            .indexWhere((item) => item.key.toString() == key.toString());

        if (pos >= 0) {
          var mItem = listitem[pos];

          if (harganum > mItem.maxharga) mItem.maxharga = harganum;
          if (harganum < mItem.minharga) mItem.minharga = harganum;

          mItem.volidr = vol;
          mItem.selisih = harganum - mItem.hargaAwal;
          mItem.hargaNum = harganum;
          mItem.hargalist.add(
              FlSpot(mItem.hargalist.length.toDouble(), harganum.toDouble()));
        } else {
          listitem.add(
            CoinModel(
                key: key,
                name: key.toUpperCase().replaceAll("_", " "),
                hargaNum: harganum,
                hargaAwal: harganum,
                maxharga: harganum,
                minharga: harganum,
                volidr: vol,
                hargalist: [FlSpot(0, harganum.toDouble())]),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
