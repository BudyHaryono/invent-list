import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_inventory/models/model.dart';
import 'package:simple_inventory/styles/style.dart';
import 'package:toast/toast.dart';

class InventList extends StatefulWidget {
  @override
  _InventListState createState() => _InventListState();
}

class _InventListState extends State<InventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.blue,
        title: Text(
          "Inventory List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.yellow
          ),
        ),
      ),
      body: itemList.isNotEmpty ? _buildItemListIfExist() : _buildItemListIfEmpty(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddListDialog(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemListIfExist() {
    return ListView(
      children: List<Widget>.generate(
        itemList.length,
            (index) {
          return FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              itemNameController = TextEditingController(text: itemList[index].name);
              itemQuantityController = TextEditingController(text: itemList[index].quantity.toString());
              itemPositionController = TextEditingController(text: itemList[index].position);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _editItemAlertDialog(context, index);
                },
                barrierDismissible: false,
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Name\t\t\t\t\t\t\t", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: itemList[index].name),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "QTY\t\t\t\t\t\t\t\t\t\t", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: itemList[index].quantity.toString()),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Position\t\t\t", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: itemList[index].position),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemListIfEmpty() {
    return Center(
      child: Text(
        "Inventory list is empty, add item first!",
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  var itemNameController = TextEditingController();
  var itemQuantityController = TextEditingController();
  var itemPositionController = TextEditingController();
  var _itemNameFocusNode = FocusNode();
  var _itemQuantityFocusNode = FocusNode();
  var _itemPositionFocusNode = FocusNode();
  bool _autoValidate = false;

  Widget yellowText(String value) {
    return Text(
      value,
      style: TextStyle(
          color: ColorUtils.yellow,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget cancelButtonAtAdd(BuildContext context) {
    return FlatButton(
      onPressed: (){
        itemNameController.clear();
        itemPositionController.clear();
        itemQuantityController.clear();
        Navigator.pop(context);
      },
      child: yellowText("CANCEL"),
    );
  }

  Widget submitButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        var validate = formKey.currentState.validate();
        if(validate) {
          setState(() {
            itemList.add(
                ItemList(
                  name: itemNameController.text,
                  quantity: int.parse(itemQuantityController.text),
                  position: itemPositionController.text,
                )
            );
          });
          Toast.show(
              "Item has been added",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM
          );
          Navigator.pop(context);
          itemNameController.clear();
          itemPositionController.clear();
          itemQuantityController.clear();
        } else {
          _autoValidate = true;
        }
      },
      child: yellowText("SUBMIT"),

    );
  }

  Widget _addListAlertDialog(BuildContext context) {
    return Form(
      key: formKey,
      // ignore: deprecated_member_use
      autovalidate: _autoValidate,
      child: AlertDialog(
        title: yellowText("Add new item"),
        backgroundColor: ColorUtils.blue,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildNameField(context),
            _buildQuantityField(context),
            _buildPositionField(context),
          ],
        ),
        actions: [cancelButtonAtAdd(context), submitButton(context)],
      ),
    );
  }

  showAddListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _addListAlertDialog(context);
      },
      barrierDismissible: false,
    );
  }

  Widget cancelButtonAtEdit(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: yellowText("CANCEL"),
    );
  }

  Widget deleteButton(BuildContext context, int deleted) {
    return FlatButton(
      onPressed: (){
        setState(() {
          itemList.removeAt(deleted);
          Navigator.pop(context);
          Toast.show(
              "Item has been deleted",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM
          );
        });
      },
      child: yellowText("DELETE"),
    );
  }

  Widget updateButton(BuildContext context, int index) {
    return FlatButton(
      onPressed: () {
        setState(() {
          itemList[index].name = itemNameController.text;
          itemList[index].quantity = int.parse(itemQuantityController.text);
          itemList[index].position = itemPositionController.text;
          Navigator.pop(context);
          Toast.show(
              "Item has been updated",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM
          );
        });
      },
      child: yellowText("UPDATE"),
    );
  }

  Widget _editItemAlertDialog (BuildContext context, int index) {
    return Form(
      child: AlertDialog(
        title: yellowText("Edit item"),
        backgroundColor: ColorUtils.blue,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildNameField(context),
            _buildQuantityField(context),
            _buildPositionField(context),
          ],
        ),
        actions: [deleteButton(context, index), cancelButtonAtAdd(context), updateButton(context,index)],
      ),
    );
  }

  String _nameValidation(String value) {
    if(value.isEmpty) {
      return "Item name can't be empty";
    } else {
      return null;
    }
  }

  Widget _buildNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: itemNameController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_itemQuantityFocusNode);
        },
        focusNode: _itemNameFocusNode,
        validator: (value) => _nameValidation(value),
        decoration: FieldStyles.textFormFieldStyle("Name", "Item name", Colors.white, Colors.white38),
      ),
    );
  }

  String _quantityValidation(String value) {
    if(value.isEmpty) {
      return "Item quantity can't be empty";
    } else {
      return null;
    }
  }

  Widget _buildQuantityField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: itemQuantityController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_itemPositionFocusNode);
        },
        focusNode: _itemQuantityFocusNode,
        validator: (value) => _quantityValidation(value),
        decoration: FieldStyles.textFormFieldStyle("Quantity", "Item quantity", Colors.white, Colors.white38),
      ),
    );
  }

  String _positionValidation(String value) {
    if(value.isEmpty) {
      return "Item position can't be empty";
    } else {
      return null;
    }
  }

  Widget _buildPositionField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: itemPositionController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (value) => _positionValidation(value),
        focusNode: _itemPositionFocusNode,
        decoration: FieldStyles.textFormFieldStyle("Position", "Item position", Colors.white, Colors.white38),
      ),
    );
  }
}

var itemList = [
  ItemList(
    name: "Vas Bunga",
    quantity: 2,
    position: "Ruang tamu",
  ),
  ItemList(
    name: "Lampu",
    quantity: 3,
    position: "Gudang",
  ),
];