import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soiree/pages/login.dart';
import 'package:soiree/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

//My Own Imports
import 'package:soiree/Animation/fadeIn.dart';
import 'package:soiree/pages/validator/authentification.dart';
import 'package:soiree/pages/validator/signup.dart';
import 'package:soiree/widget/dialog.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup>
    with InputPasswordConfirmation, InputAuthentification {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText1 = true;
  String _messageRegister = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _viewPassword1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 70.0, right: 30.0, left: 30.0),
            child: FadeIn(
              1.0,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      "Connexion",
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
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                  Text(
                    'Inscription',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alatsi',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 50.0, left: 50.0),
            child: Form(
              key: _formKey,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeIn(
                          1.4,
                          TextFormField(
                            validator: (value) {
                              if (!isEmailValid(value)) {
                                return "L'adresse email est invalide";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Adresse email',
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0),
                            ),
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeIn(
                          1.4,
                          TextFormField(
                            validator: (value) {
                              if (!isInputLength(value, 6)) {
                                return "Le nom d'utilisateur doit avoir minimum 6 caractères";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Nom d'utilisateur",
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0),
                            ),
                            controller: _usernameController,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeIn(
                          1.6,
                          TextFormField(
                            validator: (value) {
                              if (!isInputLength(value, 6)) {
                                return "Le mot de passe doit avoir minimum 6 caractères \n ";
                              }

                              if (!isPasswordSecure(value)) {
                                return "Le mot de passe ne respecte pas les règles de sécurité \n" +
                                    "Minimum 1 Upper case, \n" +
                                    "Minimum 1 lowercase, \n" +
                                    "Minimum 1 Numeric Number, \n" +
                                    "Minimum 1 Special Character \n";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _viewPassword,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0),
                            ),
                            controller: _passwordController,
                            obscureText: _obscureText,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeIn(
                          1.8,
                          TextFormField(
                            validator: (value) {
                              if (!isInputLength(value, 6)) {
                                return "Le mot de passe doit avoir minimum 6 caractères";
                              }

                              if (!isConfirmationEquals(
                                  value, _passwordController.text)) {
                                return "Les mots de passe ne sont pas identiques";
                              }
                              // if (value != _passwordController.text) {
                              //   return 'Les deux mots de passe ne sont pas identiques';
                              // }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Confirmation du mot de passe ',
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _viewPassword1,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0),
                            ),
                            obscureText: _obscureText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 7.0,
                                  ),
                                  Text(
                                    "Inscription",
                                    style: TextStyle(
                                      fontFamily: 'Alatsi',
                                      color: Theme.of(context).primaryColor,
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
                        await _register();

                        if (_messageRegister != "") {
                          showAlertDialog(context, "Erreur", _messageRegister);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeIn(
                    2.2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Compte existant?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Alatsi',
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          child: Text(
                            'Connexion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Alatsi',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    String message = "";
    if (_formKey.currentState.validate()) {
      try {
        final UserCredential userCredential =
            (await _auth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text));

        User user = FirebaseAuth.instance.currentUser;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }

        setState(() {
          _messageRegister = message;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
