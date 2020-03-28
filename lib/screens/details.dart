import 'dart:convert';

import 'package:cryptoboss/constants/colors.dart';
import 'package:cryptoboss/services/assets_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';

class DetailsScreen extends StatefulWidget {
  String id;

  DetailsScreen({this.id});

  @override
  _DetailsScreenState createState() => _DetailsScreenState(currencyId: id);
}

class _DetailsScreenState extends State<DetailsScreen> {
  String currencyId;
  dynamic currencyData;
  dynamic priceHistory;

  _DetailsScreenState({this.currencyId});

  @override
  void initState() {
    super.initState();

    try {
      AssetsService.getCurrencyDetails(currencyId).then((data) {
        setState(() {
          currencyData = data['data'];
        });
      });
    } catch (e) {
      this.currencyData = {};
      Fluttertoast.showToast(
          msg: "An error occured while getting currency details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return currencyData != null
        ? SafeArea(
            child: Container(
              color: Color.fromRGBO(
                  ColorsConstant.primary.red,
                  ColorsConstant.primary.green,
                  ColorsConstant.primary.blue,
                  0.9),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(28, 45, 107, 0.9),
                          Color.fromRGBO(40, 60, 133, 0.9),
                          Color.fromRGBO(47, 69, 148, 0.9),
                          Color.fromRGBO(60, 84, 171, 0.9),
                          Color.fromRGBO(74, 98, 189, 0.9),
                          Color.fromRGBO(82, 107, 204, 0.9),
                          Color.fromRGBO(90, 116, 219, 0.9),
                        ]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(102, 185, 237, 0.2),
                              blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:8.0, bottom: 15),
                                child: Image.asset(
                                  'images/$currencyId.png',
                                  width: 40,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Symbol',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                  Text(
                                    currencyData != null
                                        ? currencyData['symbol']
                                        : '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                  Text(
                                    currencyData != null
                                        ? currencyData['name']
                                        : '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                  Text(
                                    currencyData != null
                                        ? double.parse(currencyData['priceUsd'])
                                            .toStringAsFixed(1)
                                        : '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Rank',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Quicksand',
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      currencyData != null
                                          ? currencyData['rank']
                                          : '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Quicksand',
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '24hr. change',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Quicksand',
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      currencyData != null
                                          ? '${double.parse(currencyData['changePercent24Hr']).toStringAsFixed(2)}%'
                                          : '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Quicksand',
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Trend',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Quicksand',
                                          fontSize: 20,
                                          decoration: TextDecoration.none),
                                    ),
                                    double.parse(currencyData[
                                                'changePercent24Hr']) >
                                            0
                                        ? Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.arrow_downward,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Price history (last 50 days)',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontSize: 20,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: AssetsService.getPriceHistory(currencyId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<dynamic> itemsList = snapshot
                                    .data['data'].reversed
                                    .take(50)
                                    .toList();

                                return ListView.builder(
                                  itemCount: itemsList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(15),
                                      height: 80,
                                      width: double.infinity,
                                      margin: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  90, 116, 219, 0.3),
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(28, 45, 107, 0.9),
                                            Color.fromRGBO(40, 60, 133, 0.9),
                                            Color.fromRGBO(47, 69, 148, 0.9),
                                            Color.fromRGBO(60, 84, 171, 0.9),
                                            Color.fromRGBO(74, 98, 189, 0.9),
                                            Color.fromRGBO(82, 107, 204, 0.9),
                                            Color.fromRGBO(90, 116, 219, 0.9),
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Date:  ${DateTime.parse(itemsList[index]['date']).day}.${DateTime.parse(itemsList[index]['date']).month}.${DateTime.parse(itemsList[index]['date']).year}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 20,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Price:  \$${double.parse(itemsList[index]['priceUsd']).toStringAsFixed(5)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 20,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                index > 0 &&
                                                        index <
                                                            (itemsList.length -
                                                                1) &&
                                                        double.parse(itemsList[
                                                                    index]
                                                                ['priceUsd']) >
                                                            double.parse(
                                                                itemsList[
                                                                        index +
                                                                            1][
                                                                    'priceUsd'])
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward,
                                                color: index > 0 &&
                                                        index <
                                                            (itemsList.length -
                                                                1) &&
                                                        double.parse(itemsList[
                                                                    index]
                                                                ['priceUsd']) >
                                                            double.parse(
                                                                itemsList[
                                                                        index +
                                                                            1][
                                                                    'priceUsd'])
                                                    ? Colors.green
                                                    : Colors.red,
                                                size: 35,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return SpinKitSpinningCircle(
                                color: Colors.yellow[800],
                                size: 50.0,
                              );
                              ;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : SpinKitSpinningCircle(
            color: Colors.yellow[800],
            size: 50.0,
          );
  }
}
