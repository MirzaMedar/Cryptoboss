import 'dart:convert';

import 'package:cryptoboss/constants/colors.dart';
import 'package:cryptoboss/models/currency.dart';
import 'package:cryptoboss/providers/currenciesData.dart';
import 'package:cryptoboss/widgets/currency_item_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:cryptoboss/services/assets_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<CryptoCurrency> items = [];
  IOWebSocketChannel channel;
  int requestCounter = 0;
  bool showLoader = true;

  @override
  void initState() {
    super.initState();

    try {
      AssetsService.getAssets().then((data) {
        for (var currency in data['data']) {
          this.items.add(new CryptoCurrency(
              id: currency['id'],
              price: currency['priceUsd'],
              rank: currency['rank'],
              symbol: currency['symbol'],
              name: currency['name']));
        }
        setState(() {
          this.showLoader = false;
        });
        Provider.of<CurrenciesData>(context).setList(items);
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An error occured while getting currencies list",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    channel = IOWebSocketChannel.connect(
        'wss://ws.coincap.io/prices?assets=bitcoin,ethereum,tether,bitcoin-cash,monero,litecoin,ethereum-classic,zcash');

    channel.stream.listen((data) {
      Map<String, dynamic> decoded = jsonDecode(data);

      decoded.forEach((key, value) {
        Provider.of<CurrenciesData>(context).updateItem(key, value);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        color: Color.fromRGBO(ColorsConstant.primary.red,
            ColorsConstant.primary.green, ColorsConstant.primary.blue, 0.9),
        child: !showLoader
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CurrencyItemCardWidget(
                    currencyDetails:
                        Provider.of<CurrenciesData>(context).getByIndex(index),
                  );
                },
                itemCount: Provider.of<CurrenciesData>(context).getLength(),
              )
            : SpinKitSpinningCircle(
                color: Colors.yellow[800],
                size: 50.0,
              ),
      ),
    );
  }
}
