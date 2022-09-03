/*
 * *
 *  * Created by Vishal Patolia on 10/18/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/widget/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../home_page_component/home_screen.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({Key? key}) : super(key: key);

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  TextEditingController controller = TextEditingController(text: "");
  bool hasError = false;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify OTP",
                    style:
                        boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  const SizedBox(height: spacingContainer),
                  Text('Lorem Ipsum is simply dummy text of the printing',
                      style: normalLargeTextStyle),
                  const SizedBox(height: spacingControl),
                  Text('Mario@gmail.com', style: boldTextStyle),
                  const SizedBox(height: spacingLarge),
                  Text("Enter OTP", style: smallNormalTextStyle)
                      .addMarginLeft(spacingContainer),
                  Center(
                    child: PinCodeTextField(
                        autofocus: true,
                        controller: controller,
                        highlight: true,
                        defaultBorderColor: primaryColor,
                        highlightPinBoxColor: primaryColor,
                        pinBoxColor: Colors.white,
                        hasTextBorderColor: primaryColor,
                        highlightColor: primaryColor,
                        pinBoxBorderWidth: 2,
                        maxLength: 6,
                        hasError: hasError,
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {},
                        pinBoxWidth: 55,
                        pinBoxHeight: 64,
                        hasUnderline: false,
                        pinBoxRadius: 12,
                        wrapAlignment: WrapAlignment.spaceBetween,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.amber,
                        keyboardType: TextInputType.number),
                  ).addMarginTop(spacingContainer),
                  const SizedBox(height: spacingContainer),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t receive the OTP? ',
                          style: normalTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Resend OTP',
                                style: boldLargeTextStyle.copyWith(
                                    color: btnBgColor,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ]),
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                      child: const ButtonWidget(text: "Verify")
                          .wrapPaddingAll(spacingContainer),
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          SlideRightRoute(page: const HomeScreen()),
                          (Route<dynamic> route) => false)),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
