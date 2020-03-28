import 'package:cryptoboss/constants/colors.dart';
import 'package:cryptoboss/screens/home.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(ColorsConstant.primary.red,
            ColorsConstant.primary.green, ColorsConstant.primary.blue, 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/bitcoin-logo.png',
              width: 200,
            ),
            Text(
              'Cryptoboss',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  decoration: TextDecoration.none),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Made with ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      decoration: TextDecoration.none,
                      fontFamily: 'Quicksand'),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 10,
                ),
                Text(
                  ' by Mirza Medar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      decoration: TextDecoration.none,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlineButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(166, 124, 0, 0.9)),
                  hoverColor: Color.fromRGBO(166, 124, 0, 0.9),
                  focusColor: Color.fromRGBO(166, 124, 0, 0.9),
                  splashColor: Color.fromRGBO(166, 124, 0, 0.9),
                  highlightColor: Color.fromRGBO(166, 124, 0, 0.9),
                  highlightedBorderColor: Color.fromRGBO(166, 124, 0, 0.9),
                  disabledBorderColor: Color.fromRGBO(166, 124, 0, 0.9),
                  color: Color.fromRGBO(166, 124, 0, 0.9),
                  child: Text(
                    'Get started',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Quicksand',
                        fontSize: 30),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered by ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      decoration: TextDecoration.none,
                      fontFamily: 'Quicksand'),
                ),
                Image.asset(
                  'images/black.png',
                  width: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
