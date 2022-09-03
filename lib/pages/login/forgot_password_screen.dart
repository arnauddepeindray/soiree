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
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/validator/authentification.dart';
import 'package:soiree/widget/button_widget.dart';
import 'package:soiree/widget/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';
import '../../provider.dart';
import '../../utils/messageProvider.dart';
import '../../widget/dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with InputAuthentification {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context)!.auth;
    final MessageProvider messageProvider = Provider.of(context)!.messageProvider;

    void _onTap () async {
      if (_formKey.currentState!.validate()) {
        try {
          await auth.resetPassword(_emailController.text);
          messageProvider.createMessage("Erreur d'authentification", "Un email de réinitialisation de mot de passe a été envoyer");
          Navigator.of(context).pushReplacement(
              SlideRightRoute(page: const LoginScreen()));
        } on FirebaseAuthException catch (e) {
          String? message = e.message;
          if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
          }
          showAlertDialog(context, "Erreur", message);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("", context),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mot de passe oublié",
                    style: boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Lorem Ipsum is simply dummy text of the printing',
                      style: normalLargeTextStyle),
                  const SizedBox(height: spacingLarge),
                  Text("Adresse email", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  TextFormWidget(hintText: "Entrer votre adresse email", textEditingController: _emailController,onValidation: (value){
                    if (!isInputLength(value!, 1)) {
                      return "L'adresse mail est requis";
                    }

                    if (!isEmailValid(value)) {
                      return "L'adresse email est invalide";
                    }
                    return null;
                  },),
                  const SizedBox(height: spacingContainer),
                  ButtonWidget(text: "Réinitialiser", onTap: _onTap,)
                      .wrapPaddingAll(spacingContainer),
                  InkWell(
                    child: Center(
                        child: Text("Retour à la connexion",
                            style: boldTextStyle.copyWith(
                                fontSize: textSizeLargeMedium)))
                        .addMarginTop(spacingStandard),
                    onTap: () => {
                      Navigator.of(context).pushReplacement(
                          SlideRightRoute(page: const LoginScreen()))
                    },
                  ),
                ],
              ).wrapPaddingAll(spacingContainer),
            )


          )),
    );
  }
}
