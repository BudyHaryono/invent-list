import 'package:flutter/material.dart';
import 'package:simple_inventory/main_screen/item_list.dart';
import 'package:simple_inventory/models/model.dart';
import 'package:simple_inventory/styles/style.dart';
import 'package:toast/toast.dart';

class AddListMenu{
  final formKey = GlobalKey<FormState>();
  var _itemNameController = TextEditingController();
  var _itemQuantityController = TextEditingController();
  var _itemPositionController = TextEditingController();
  var _itemNameFocusNode = FocusNode();
  var _itemQuantityFocusNode = FocusNode();
  var _itemPositionFocusNode = FocusNode();

  Widget yellowText(String value) {
    return Text(
      value,
      style: TextStyle(
        color: ColorUtils.yellow,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return FlatButton(
      onPressed: (){
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
          itemList.add(
              ItemList(
                name: _itemNameController.text,
                quantity: int.parse(_itemQuantityController.text),
                position: _itemPositionController.text,
              )
          );
          Toast.show(
              "Item has been added",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM
          );
          Navigator.pop(context);
        } else {
          Toast.show(
              "Field can't be empty",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM
          );
          Navigator.pop(context);
        }
      },
      child: yellowText("SUBMIT"),

    );
  }

  Widget _alertDialog(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: yellowText("Add new item"),
        backgroundColor: ColorUtils.blue,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameField(context),
            _buildQuantityField(context),
            _buildPositionField(context),
          ],
        ),
        actions: [cancelButton(context), submitButton(context)],
      ),
    );
  }

  showAddListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(context);
      },
      // barrierDismissible: false,
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
        controller: _itemNameController,
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
        controller: _itemQuantityController,
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
        controller: _itemPositionController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (value) => _positionValidation(value),
        focusNode: _itemPositionFocusNode,
        decoration: FieldStyles.textFormFieldStyle("Position", "Item position", Colors.white, Colors.white38),
      ),
    );
  }
}