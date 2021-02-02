import 'package:flutter/material.dart';
import 'package:simple_inventory/main_screen/add_list.dart';
import 'package:simple_inventory/login_screen.dart';
import 'package:simple_inventory/main_screen/item_list.dart';
import 'package:simple_inventory/main_screen/my_contact.dart';
import 'package:simple_inventory/styles/style.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: ColorUtils.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Main Menu",
                  style: TextStyle(
                    color: ColorUtils.yellow,
                    fontSize: 37
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        iconSize: 140,
                        color: ColorUtils.yellow,
                        onPressed: () {
                          AddListMenu().showAddListDialog(context);
                        },
                      ),
                      Text(
                        "Add Item",
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorUtils.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.list),
                        iconSize: 140,
                        color: ColorUtils.yellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return InventList();
                              }
                            ),
                          );
                        },
                      ),
                      Text(
                        "Item List",
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorUtils.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout),
                      iconSize: 140,
                      color: ColorUtils.yellow,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                          return LoginScreen();
                        }));
                      },
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorUtils.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.help),
                      iconSize: 140,
                      color: ColorUtils.yellow,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyContact();
                            }
                          ),
                        );
                      },
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorUtils.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}