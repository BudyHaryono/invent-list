import 'package:flutter/material.dart';

class FieldStyles {
  static textFormFieldStyle(String categ, String hint, Color color, Color hintColor) {
    return InputDecoration(
      labelText: categ,
      labelStyle: TextStyle(
        color: color,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: hintColor,
      ),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      ),
    );
  }
}

class ColorUtils{
  static const Color blue = Color.fromARGB(255, 72, 133, 180);
  static const Color yellow = Color.fromARGB(255, 255, 165, 6);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
}

class LoginButton1 extends StatelessWidget {
  final Widget child;
  final double width, height;
  final Function onPressed;

  const LoginButton1({
    Key key,
    this.width = double.infinity,
    this.height = 40.0,
    this.onPressed,
    @required this.child,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: ColorUtils.yellow,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            blurRadius: 1.5,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}