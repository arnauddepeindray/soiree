import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soiree/main.dart';
import 'package:soiree/pages/home.dart';
import 'package:soiree/pages/signup.dart';
import 'package:soiree/pages/forgot_password.dart';

//My Own Imports
import 'package:soiree/Animation/fadeIn.dart';
import 'package:soiree/pages/validator/authentification.dart';
import 'package:soiree/widget/dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with InputAuthentification {
  // Initially password is obscure
  bool _obscureText = true;
  DateTime currentBackPressTime;

  String _messageLogin = "";
  bool _isError = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 70.0, right: 30.0, left: 30.0),
              child: FadeIn(
                1.0,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Connexion",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alatsi',
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Inscription',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Alatsi',
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 50.0, left: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeIn(
                    1.2,
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/GoKart.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    FadeIn(
                                      1.4,
                                      TextFormField(
                                        validator: (value) {
                                          if (!isInputLength(value, 1)) {
                                            return "L'adresse mail est requis";
                                          }

                                          if (!isEmailValid(value)) {
                                            return "L'adresse email est invalide";
                                          }
                                          return null;
                                        },
                                        controller: _emailLoginController,
                                        decoration: InputDecoration(
                                          hintText: "Adresse email",
                                          contentPadding: const EdgeInsets.only(
                                              top: 12.0, bottom: 12.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    FadeIn(
                                      1.6,
                                      TextFormField(
                                        validator: (value) {
                                          if (!isInputLength(value, 1)) {
                                            return "Le mot de passe est requis";
                                          }
                                          return null;
                                        },
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          hintText: 'Mot de passe',
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.remove_red_eye),
                                            onPressed: _viewPassword,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12.0, bottom: 12.0),
                                        ),
                                        obscureText: _obscureText,
                                      ),
                                    ),
                                  ])),
                              SizedBox(
                                height: 10.0,
                              ),
                              FadeIn(
                                1.8,
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    child: Text(
                                      'Mot de passe oublié?',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'Alatsi',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              FadeIn(
                                2.0,
                                InkWell(
                                  child: Container(
                                    height: 45.0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.grey[300],
                                      color: Colors.white,
                                      borderOnForeground: false,
                                      elevation: 5.0,
                                      child: GestureDetector(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                "CONNEXION",
                                                style: TextStyle(
                                                  fontFamily: 'Alatsi',
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    await _login();

                                    if (_messageLogin != "" && !_isError) {
                                      showAlertDialog(
                                          context,
                                          "Erreur d'authentification",
                                          _messageLogin);
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              FadeIn(
                                2.2,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Compte existant ?',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15.0,
                                        fontFamily: 'Alatsi',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        'Inscription',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 18.0,
                                          fontFamily: 'Alatsi',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Signup()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              FadeIn(
                                2.4,
                                Text(
                                  "Continuer avec",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontFamily: 'Alatsi',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FadeIn(
                                    2.6,
                                    InkWell(
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/google_plus.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(30.0)),
                                          border: new Border.all(width: 0.0),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18.0,
                                  ),
                                  FadeIn(
                                    2.8,
                                    InkWell(
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          image: new DecorationImage(
                                            image:
                                                new AssetImage('assets/fb.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(30.0)),
                                          border: new Border.all(width: 0.0),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          ],
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  void dispose() {
    _emailLoginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String messageSend = "";
    if (_formKey.currentState.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailLoginController.text,
            password: _passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          messageSend = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          messageSend = 'Wrong password provided for that user.';
        }

        setState(() {
          _messageLogin = messageSend;
        });
        setState(() {
          _isError = true;
        });
      }
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Appuyer pour quitter',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }
}
