import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/pages/signup.dart';
import 'package:soiree/pages/login.dart';

//My Own Imports
import 'package:soiree/Animation/fadeIn.dart';
import 'package:soiree/pages/validator/authentification.dart';
import 'package:soiree/provider.dart';
import 'package:soiree/utils/messageProvider.dart';
import 'package:soiree/widget/dialog.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with InputAuthentification {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    final MessageProvider messageProvider = Provider.of(context).messageProvider;
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
                  Text(
                    "Mot de passe oublié?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
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
                      height: 30.0,
                    ),
                    FadeIn(
                      1.4,
                      TextFormField(
                        validator: (value) {
                          if (!isEmailValid(value)) {
                            return "L'email n'est pas valide";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Votre adresse email',
                          contentPadding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    FadeIn(
                      1.6,
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
                                      "Réinitialisation du mot de passe",
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
                          if (_formKey.currentState.validate()) {
                            try {
                              await auth.resetPassword(_emailController.text);
                              messageProvider.createMessage("Erreur d'authentification", "Un email de réinitialisation de mot de passe a été envoyer");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            } on FirebaseAuthException catch (e) {
                              String message = e.message;
                              if (e.code == 'user-not-found') {
                                message = 'No user found for that email.';
                              }
                              showAlertDialog(context, "Erreur", message);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    FadeIn(
                      1.8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Naviguez à ',
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
                              'Connexion',
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
                                    builder: (context) => Login()),
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
              )),
        ],
      ),
    );
  }

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
