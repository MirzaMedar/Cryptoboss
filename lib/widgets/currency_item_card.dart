import 'dart:async';

import 'package:cryptoboss/models/currency.dart';
import 'package:cryptoboss/screens/details.dart';
import 'package:flutter/material.dart';

class CurrencyItemCardWidget extends StatefulWidget {
  final CryptoCurrency currencyDetails;
  CurrencyItemCardWidget({this.currencyDetails});

  @override
  _CurrencyItemCardWidgetState createState() =>
      _CurrencyItemCardWidgetState(currencyInfo: currencyDetails);
}

class _CurrencyItemCardWidgetState extends State<CurrencyItemCardWidget> {
  bool change = false;
  bool increased = false;
  final CryptoCurrency currencyInfo;
  LinearGradient gradient = LinearGradient(colors: [
    Color.fromRGBO(54, 60, 112, 0.9),
    Color.fromRGBO(54, 60, 112, 0.9),
    Color.fromRGBO(65, 72, 130, 0.9),
    Color.fromRGBO(65, 72, 130, 0.9),
    Color.fromRGBO(77, 85, 153, 0.9),
  ]);
  var timer;

  _CurrencyItemCardWidgetState({this.currencyInfo});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      gradient = currencyInfo.changed
          ? !currencyInfo.increased
              ? LinearGradient(colors: [
                  Colors.red,
                  Colors.redAccent,
                  Color.fromRGBO(95, 103, 173, 0.9),
                ])
              : LinearGradient(colors: [
                  Colors.green,
                  Colors.greenAccent,
                  Color.fromRGBO(95, 103, 173, 0.9),
                ])
          : LinearGradient(colors: [
              Color.fromRGBO(54, 60, 112, 0.9),
              Color.fromRGBO(54, 60, 112, 0.9),
              Color.fromRGBO(65, 72, 130, 0.9),
              Color.fromRGBO(65, 72, 130, 0.9),
              Color.fromRGBO(77, 85, 153, 0.9),
            ]);
    });

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new DetailsScreen(
              id: currencyInfo.id,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'images/${currencyInfo.id}.png',
                          width: 40,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currencyInfo.symbol,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Quicksand',
                                decoration: TextDecoration.none),
                          ),
                          Text(
                            currencyInfo.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontSize:
                                    currencyInfo.name.length > 12 ? 15 : 20,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '\$${double.parse(currencyInfo.price).toStringAsFixed(5)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontSize: 15,
                              decoration: TextDecoration.none),
                        ),
                        Row(
                          children: <Widget>[
                            currencyInfo.percentage != ''
                                ? Text(
                                    '${currencyInfo.percentage}%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quicksand',
                                        fontSize: 15,
                                        decoration: TextDecoration.none),
                                  )
                                : Text(''),
                            currencyInfo.percentage != ''
                                ? currencyInfo.increased
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
                                : Text('')
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        this.currencyInfo.rank,
                        style: TextStyle(
                            color: Color.fromRGBO(77, 109, 153, 0.9),
                            fontFamily: 'Quicksand',
                            fontSize: 25,
                            decoration: TextDecoration.none),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Color.fromRGBO(77, 109, 153, 0.9),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromRGBO(105, 142, 194, 0.9),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
