import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_inventory/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class MyContact extends StatefulWidget {
  @override
  _MyContactState createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  var textStyle = TextStyle(
    fontFamily: "RobotoMono",
    fontSize: 15,
    color: ColorUtils.blue
  );

  bool isTap = false;

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
                "\n You can contact on these platforms :\n",
            style: TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 20,
                color: ColorUtils.blue
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Github\t\t\t\t\t\t:",
                style: textStyle,
                textAlign: TextAlign.left,
              ),
              isTap ? contactInfo(" BudyHaryono/invent-list", 'https://github.com/BudyHaryono/invent-list') : tapButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "E-mail\t\t\t\t\t\t:",
                style: textStyle,
                textAlign: TextAlign.left,
              ),
              isTap ? contactInfo(" budypro423@gmail.com", 'mailto:budypro423@gmail.com') : tapButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Instagram:",
                style: textStyle,
                textAlign: TextAlign.left,
              ),
              isTap ? contactInfo(' budy.hryno', 'https://www.instagram.com/ariessanndn/') : tapButton(),
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

  Widget contactInfo(String value, String link) {
    return InkWell(
      onTap: () => launch(link),
      child: Text(
        value,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontFamily: 'RobotoMono',
          fontSize: 15,
          color: ColorUtils.yellow,
        ),
      ),
    );
  }
}