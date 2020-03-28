import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AssetsService {
  static Future<dynamic> getAssets() async {
    String url =
        'https://api.coincap.io/v2/assets?ids=bitcoin,ethereum,tether,bitcoin-cash,monero,litecoin,ethereum-classic,zcash';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return Future.value(jsonResponse);
    } else {
      throw Exception('An error occured while getting list of currencies!');
    }
  }

  static Future<dynamic> getCurrencyDetails(String currencyId) async {
    String url = 'https://api.coincap.io/v2/assets/$currencyId';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return Future.value(jsonResponse);
    } else {
      throw Exception('An error occured while getting currency details!');
    }
  }

  static Future<dynamic> getPriceHistory(String currencyId) async {
    String url =
        'https://api.coincap.io/v2/assets/$currencyId/history?interval=d1';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return Future.value(jsonResponse);
    } else {
      throw Exception('An error occured while getting price history!');
    }
  }
}
