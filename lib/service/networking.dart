import 'dart:convert';

import 'package:bitcoin_ticker/utils/api_key.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;
  String currency;
  String crypto;

  NetworkHelper(this.currency, this.crypto) {
    url = "https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$kApiKey";
    print(url);
  }

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Something went wrong");
    }
  }
}
