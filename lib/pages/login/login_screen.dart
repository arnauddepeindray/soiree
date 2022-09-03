/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:soiree/pages/register/register_screen.dart';
import 'package:soiree/pages/register/verify_otp_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/widget/button_widget.dart';
import 'package:soiree/widget/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../provider.dart';
import '../../utils/messageProvider.dart';
import '../../validator/authentification.dart';
import '../../widget/dialog.dart';
import '../home_page_component/home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputAuthentification {
  TextEditingController emailController =
      TextEditingController(text: "");
  TextEditingController passwordController =
      TextEditingController(text: "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _messageLogin = "";
  bool _isError = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(BuildContext context){
    MessageProvider messageProvider = Provider.of(context)!.messageProvider;
    if(messageProvider.needToLog){
      showAlertDialog(context, messageProvider.getTitle(), messageProvider.getMessage());
    }
  }

  Future<void> _login() async {
    String messageSend = "";
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
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


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      showMessage(context);
    });

    void _loginSumbit() async {
      await _login();
      debugPrint(_messageLogin + " Erreur : " + _isError.toString());
      if (_isError) {
        showAlertDialog(
            context,
            "Erreur d'authentification",
            _messageLogin);
      } else {
        Navigator.of(context).push(
            SlideRightRoute(page: const HomeScreen()));
      }

    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("", context),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Se connecter",
                      style:
                      boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                    ),
                    const SizedBox(height: spacingContainer),
                    Text('Lorem Ipsum is simply dummy text of the printing',
                        style: normalLargeTextStyle),
                    const SizedBox(height: spacingLarge),
                    Text("Adresse email :", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(
                        textEditingController: emailController,
                        hintText: "Entrer votre adresse email",
                        onValidation: (value) {
                          if (!isInputLength(value!, 1)) {
                            return "L'adresse mail est requis";
                          }

                          if (!isEmailValid(value)) {
                            return "L'adresse email est invalide";
                          }
                          return null;
                        },
                    ),
                    const SizedBox(height: spacingContainer),
                    Text("Mot de passe", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(
                        textEditingController: passwordController,
                        hintText: "Entrer votre mot de passe",
                        onValidation: (value) {
                          if (!isInputLength(value!, 1)) {
                            return "Le mot de passe est requis";
                          }
                          return null;
                        },
                    ),
                    InkWell(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Mot de passe oublié?",
                          style: boldTextStyle,
                        ).wrapPaddingAll(spacingStandard),
                      ),
                      onTap: () => Navigator.of(context).push(
                          SlideRightRoute(page: const ForgotPasswordScreen())),
                    ),
                    InkWell(
                      child: ButtonWidget(text: "Se connecter", onTap: _loginSumbit,)
                          .wrapPaddingAll(spacingContainer),
                      onTap: () {

                      },
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Vous n'avez pas de compte?",
                            style: normalTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Inscription',
                                  style: boldLargeTextStyle.copyWith(
                                      color: btnBgColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(SlideRightRoute(
                                          page: const RegisterScreen()));
                                    })
                            ]),
                      ).addMarginBottom(spacingLarge),
                    ).addMarginTop(spacingStandard),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: primaryColor,
                            width: MediaQuery.of(context).size.width,
                          ).wrapPadding(
                              padding: const EdgeInsets.only(
                                  left: spacingContainer,
                                  right: spacingContainer)),
                        ),
                        Text("Ou se connecter avec", style: mediumTextStyle),
                        Expanded(
                          child: Container(
                              height: 1,
                              color: primaryColor,
                              width: MediaQuery.of(context).size.width)
                              .wrapPadding(
                              padding: const EdgeInsets.only(
                                  left: spacingContainer,
                                  right: spacingContainer)),
                        )
                      ],
                    ),
                    const SizedBox(height: spacingContainer),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor),
                        child: Center(
                            child: Image.asset(
                              "assets/gmail.png",
                              height: 28,
                              width: 28,
                            )),
                      ),
                      const SizedBox(width: spacingContainer),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor),
                        child: Center(
                            child: Image.asset(
                              "assets/facebook.png",
                              height: 28,
                              width: 28,
                            )),
                      )
                    ])
                  ],
                ).wrapPaddingAll(spacingContainer),
              )
            ),
          )),
    );
  }
}
