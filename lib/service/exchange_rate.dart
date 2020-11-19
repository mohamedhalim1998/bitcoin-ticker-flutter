import 'package:bitcoin_ticker/service/networking.dart';

Future<int> getExchangeRate(String currency, String crypto) async {
  try {
    var data = await NetworkHelper(currency, crypto).getData();
    return data['rate'].toInt();
  } catch (e) {
    return -1;
  }
}
