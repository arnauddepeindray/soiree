/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Animation/slide_right_route.dart';
import '../home_page_component/home_screen.dart';

class EventAddedScreen extends StatefulWidget {
  const EventAddedScreen({Key? key}) : super(key: key);

  @override
  _EventAddedScreenState createState() => _EventAddedScreenState();
}

class _EventAddedScreenState extends State<EventAddedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _redirectToHome () {
      Navigator.of(context).push(
          SlideRightRoute(page: const HomeScreen()));
    }
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/success.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Votre soirée a bien été poster',
                      style:
                          boldLargeTextStyle.copyWith(fontSize: textSizeLarge)),
                  const SizedBox(height: spacingContainer),
                  Text(
                    'Voir les détails de la soirée',
                    style: mediumTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: spacingContainer),
                  ButtonWidget(text: "Retour à l'accueil", left: Icons.arrow_left, onTap: _redirectToHome ).wrapPaddingAll(spacingContainer),
                  const SizedBox(height: spacingContainer),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width *1,
                          minHeight: buttonHeight),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/share.png',
                            color: Colors.white,
                            height: 34,
                            width: 34,
                          ),
                          Text(
                            'Envoyer le à vos amis',
                            textAlign: TextAlign.center,
                            style: boldLargeTextStyle.copyWith(
                                color: Colors.white, fontSize: textSizeNormal),
                          ).addMarginLeft(16),
                        ],
                      ),
                    ),
                  ),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
