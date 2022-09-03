/*
 * *
 *  * Created by Vishal Patolia on 10/6/21, 5:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 10/6/21, 5:38 PM
 *
 */

import 'package:soiree/pages/home_page_component/home_screen.dart';
import 'package:soiree/pages/login/login_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(SlideRightRoute(page: const HomeScreen()));
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle =
        normalTextStyle.copyWith(fontSize: textSizeLargeMedium);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: boldLargeTextStyle.copyWith(
          fontSize: textSizeLarge, color: primaryColor),
      bodyTextStyle: bodyStyle,
      //descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: backgroundColor,
          pages: [
            PageViewModel(
              title: "Gérer vos soirées, en toute simplicité",
              body:
                  "Organiser vos soirées, inviter vos amis à participer à vos meilleurs évenements.",
              image: _buildImage('onboard_a.png').wrapPaddingAll(16),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Voir les soirées disponible",
              body:
                  "Trouve la soirée qui te correspond, réserve ta place et amusez-vous",
              image: _buildImage('onboard_b.png').wrapPaddingAll(16),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Partagez votre avis",
              body:
                  "Votre avis compte ! Aidez nous à améliorer l'application",
              image: _buildImage('onboard_c.png'),
              decoration: pageDecoration,
            )
          ],
          onDone: () => _onIntroEnd(context),
          showSkipButton: true,
          dotsFlex: 0,
          nextFlex: 0,
          //rtl: true, // Display as right-to-left
          skip:
              Text('Ignorer', style: boldTextStyle.copyWith(color: primaryColor)),
          next: const Icon(Icons.keyboard_arrow_right_rounded,
              color: primaryColor),
          done:
              Text('Terminer', style: boldTextStyle.copyWith(color: primaryColor)),

          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: primaryColor,
            activeColor: primaryColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              side: BorderSide(
                  color: primaryColor, width: 5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
