import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/styles/style.dart';

class MyContact extends StatefulWidget {
  @override
  _MyContactState createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  var textStyle = TextStyle(
    fontFamily: "RobotoMono",
    fontSize: 20,
    color: ColorUtils.blue
  );

  bool isTap = false;

  // final tapButton = FlatButton(
  //   padding: EdgeInsets.zero,
  //   onPressed: () {
  //     setState(() {
  //
  //     });
  //   },
  //   child: Text(
  //     "Tap to see",
  //     style: TextStyle(
  //       fontFamily: 'RobotoMono',
  //       fontSize: 20,
  //       color: ColorUtils.yellow,
  //     ),
  //   ),
  // );


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.blue,
        title: Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.yellow,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "A simple application to list inventory."
                "\n\nDeveloped by:"
                "\nBudy Haryono"
                "\n\nFor further information or help"
                "\n You can contact on these platforms :",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Github\t\t\t\t\t\t:",
                style: textStyle,
              ),
              isTap ? tapButton() : contactInfo("github.com/BudyHaryono"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "E-mail\t\t\t\t\t\t:",
                style: textStyle,
              ),
              tapButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Instagram:",
                style: textStyle,
              ),
              tapButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget tapButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTap = true;
        });
      },
      child: Text(
        "Tap to see",
        style: TextStyle(
          fontFamily: 'RobotoMono',
          fontSize: 20,
          color: ColorUtils.yellow,
        ),
      ),
    );
  }

  Widget contactInfo(String value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'RobotoMono',
        fontSize: 20,
        color: ColorUtils.yellow,
      ),
    );
  }
}