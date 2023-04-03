/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soiree/pages/login/login_screen.dart';
import 'package:soiree/pages/register/verify_otp_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/utils/strings.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/widget/button_widget.dart';
import 'package:soiree/widget/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../validator/authentification.dart';
import '../../validator/signup.dart';
import '../../widget/dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with InputPasswordConfirmation, InputAuthentification {
  bool selectTerms = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _messageRegister = "";
  bool passwordVisible = true;
  bool passwordConfirmVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    String message = "";
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
        (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text));

        User? user = FirebaseAuth.instance.currentUser;

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

  @override
  Widget build(BuildContext context) {

    void _onSubmit () async {
      await _register();

      if (_messageRegister != "") {
        showAlertDialog(context, "Erreur", _messageRegister);
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
                      "Inscription",
                      style:
                      boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                    ),
                    const SizedBox(height: spacingContainer),
                    Text('Lorem Ipsum is simply dummy text of the printing',
                        style: normalLargeTextStyle),
                    const SizedBox(height: spacingLarge),
                    Text("Nom d'utilisateur", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(hintText: "Entrer votre nom d'utilisateur", textEditingController: _usernameController,
                      onValidation: (value) {
                        if (!isInputLength(value!, 6)) {
                          return "Le nom d'utilisateur doit avoir minimum 6 caractères";
                        }

                        return null;
                      },),
                    const SizedBox(height: spacingContainer),
                    Text("Adresse email", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(hintText: "Entrer votre adresse email", textEditingController: _emailController, onValidation: (value) {
                      if (!isEmailValid(value!)) {
                        return "L'adresse email est invalide";
                      }

                      return null;
                    },),
                    const SizedBox(height: spacingContainer),
                    Text("Mot de passe", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(
                      hintText: "Entrer votre mot de passe",
                      obscureText: passwordVisible,
                      maxLines: 1,
                      iconButton: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                                () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      textEditingController: _passwordController,
                      onValidation: (value) {
                      if (!isInputLength(value!, 6)) {
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
                    },),
                    const SizedBox(height: spacingContainer),
                    Text("Confirmation du mot de passe", style: smallNormalTextStyle)
                        .addMarginLeft(spacingContainer),
                    TextFormWidget(
                        hintText: "Entrer la confirmation de votre mot de passe",
                        maxLines: 1,
                        obscureText: passwordConfirmVisible,
                        iconButton: IconButton(
                          icon: Icon(passwordConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                                  () {
                                    passwordConfirmVisible = !passwordConfirmVisible;
                              },
                            );
                          },
                        ),
                        onValidation: (value) {
                          if (!isInputLength(value!, 6)) {
                            return "Le mot de passe doit avoir minimum 6 caractères";
                          }

                          if (!isConfirmationEquals(
                              value, _passwordController.text)) {
                            return "Les mots de passe ne sont pas identiques";
                          }

                          return null;
                        }
                    ),
                    const SizedBox(height: spacingContainer),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: primaryColor,
                          fillColor: MaterialStateProperty.all(primaryColor),
                          hoverColor: primaryColor.withOpacity(0.3),
                          value: selectTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              selectTerms = value!;
                            });
                          },
                        ),
                        RichText(
                          text: TextSpan(
                              text: "J'ai lu et j'accepte les",
                              style: normalTextStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Terms & Conditions',
                                    style: boldTextStyle.copyWith(
                                        color: btnBgColor,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchURL(termsCondition, context);
                                      })
                              ]),
                        ).wrapPaddingAll(spacingStandard),
                      ],
                    ),
                    InkWell(
                      child: const ButtonWidget(text: "Inscription")
                          .wrapPaddingAll(spacingContainer),
                      onTap: () {

                      },
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Compte existante?',
                            style: normalTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Connexion',
                                  style: boldLargeTextStyle.copyWith(
                                      color: btnBgColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(SlideRightRoute(
                                          page: const LoginScreen()));
                                    })
                            ]),
                      ).addMarginBottom(spacingLarge),
                    ).addMarginTop(spacingStandard),
                  ],
                ).wrapPaddingAll(spacingContainer),
              )


            ),
          )),
    );
  }
}
