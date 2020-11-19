import 'package:bitcoin_ticker/service/exchange_rate.dart' as ExchangeRate;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'utils/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = "USD";
  int BTC = -1;
  int ETH = -1;
  int LCT = -1;

  @override
  void initState() {
    super.initState();
    updateRate();
  }

  void updateRate() async {
    BTC = await ExchangeRate.getExchangeRate(currentCurrency, "BTC");
    ETH = await ExchangeRate.getExchangeRate(currentCurrency, "ETH");
    LCT = await await ExchangeRate.getExchangeRate(currentCurrency, "LCT");
    updateUi(currentCurrency);
  }

  Widget createAndroidPicker() {
    List<DropdownMenuItem> items = [];
    for (String s in currenciesList) {
      items.add(DropdownMenuItem(child: Text(s), value: s));
    }
    return DropdownButton(
      items: items,
      value: currentCurrency,
      onChanged: (value) async {
        currentCurrency = value;
        updateRate();
      },
    );
  }

  Widget createIosPicker() {
    List<Text> items = [];
    for (String s in currenciesList) {
      items.add(Text(s));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (index) async {
          var value = items[index].data;
          currentCurrency = value;
          updateRate();
        },
        children: items);
  }

  void updateUi(String value) {
    setState(() {
      BTC = BTC;
      ETH = ETH;
      LCT = LCT;
      currentCurrency = value;
    });
  }

  Widget createRateCard(String label, int rate) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            rate == -1
                ? '1 $label = ? $currentCurrency'
                : '1 $label = $rate $currentCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          createRateCard("BTC", BTC),
          createRateCard("ETH", ETH),
          createRateCard("LTC", LCT),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? createIosPicker() : createAndroidPicker(),
          ),
        ],
      ),
    );
  }
}
