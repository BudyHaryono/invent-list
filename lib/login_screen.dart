import 'package:flutter/material.dart';
import 'package:simple_inventory/main_screen/main_screen.dart';
import 'package:simple_inventory/models/model.dart';
import 'package:simple_inventory/styles/style.dart';

class LoginScreen extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorUtils.blue,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: ColorUtils.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 150,
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmailController = TextEditingController();
  var _userPassController = TextEditingController();
  var _emailFocusNode = FocusNode();
  var _passFocusNode = FocusNode();
  bool _isPassVisible = false;
  bool _autoValidate= false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      //ignore: deprecated_member_use
      autovalidate: _autoValidate,
      child: Card(
        elevation: 8,
        child: Column(
          children: <Widget>[
            _buildLogo(),
            _buildIntroText(),
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildSignUpButton(context),
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  "*Use\nexp@exp.com\n123456789",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Image.asset(
        "images/sign-in_icon.png",
        color: ColorUtils.yellow,
        height: 100,
        width: 100,
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 30),
      child: Text(
        "My Inventory",
        style: TextStyle(
          color: ColorUtils.yellow,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _emailValidation(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(value.isEmpty) {
      return "Please enter e-mail address!";
    } else if (!emailValid) {
      return "Enter valid e-mail address!";
    } else {
      return null;
    }
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextFormField(
        controller: _userEmailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        focusNode: _emailFocusNode,
        validator: (value) => _emailValidation(value),
        decoration: FieldStyles.textFormFieldStyle("Email", "Your E-Mail", Colors.black, Colors.black38),
      ),
    );
  }

  String _passValidation(String value) {
    if(value.isEmpty) {
      return "Password can't be empty!";
    } else if (value.length < 8) {
      return "Password is too short!";
    } else {
      return null;
    }
  }

  void _passVisibility() {
    setState(() {
      _isPassVisible = !_isPassVisible;
    });
  }

  bool _showText(value) {
    if(value == false) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextFormField(
        controller: _userPassController,
        keyboardType: TextInputType.text,
        textInputAction:  TextInputAction.next,
        focusNode: _passFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        validator: (value) => _passValidation(value),
        obscureText: _showText(_isPassVisible),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Your Password",
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          suffixIcon: IconButton(
            icon: Icon(
              _isPassVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: () {
              _passVisibility();
            },
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Ok"),
    );

    Widget _alertDialog() {
      return AlertDialog(
        title: Text("Alert!"),
        content: Text("Email/Password is Wrong!"),
        actions: [okButton],
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog();
      },
      barrierDismissible: false,
    );
  }

  int emailVal = 0;
  int passVal = 0;

  void _loginProcess(BuildContext context) {
    var validate = _formKey.currentState.validate();

    if(validate) {
      for(int i = 0;i < loginDataList.length; i++) {
        if(_userEmailController.text == loginDataList[i].emailAddress) {
          emailVal = 1;
          if(_userPassController.text == loginDataList[i].password) {
            passVal = 1;
            break;
          } else {
            passVal = 0;
          }
          break;
        } else {
          emailVal = 0;
        }
      }

      if(emailVal == 1 && passVal == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return MainScreen();
                }
            )
        );
      } else {
        showAlertDialog(context);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        child: LoginButton1(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            setState(() {
              _loginProcess(context);
            });
          },
        ),
      ),
    );
  }
}

var loginDataList = [
  LoginData(
    emailAddress: "exp@exp.com",
    password: "123456789",
  ),
  LoginData(
    emailAddress: "budy@gmail.com",
    password: "submissiondicoding",
  ),
  LoginData(
    emailAddress: "budy@yahoo.com",
    password: "flutterbasic"
  ),
];