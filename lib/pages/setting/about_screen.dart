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
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: toolbarBack("About", context),
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
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                  Text(
                    "Event Pro",
                    style:
                        boldLargeTextStyle.copyWith(fontSize: textSizeXLarge),
                  ),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: normalTextStyle)
                      .wrapPadding(
                          padding: const EdgeInsets.only(
                              top: spacingControl,
                              bottom: spacingControl,
                              left: spacingContainer,
                              right: spacingContainer)),
                  Text('Developed by',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Text('Sdreatech Pvt. Ltd', style: normalLargeTextStyle)
                      .addMarginTop(spacingControl),
                  Text('Version Info',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Text(_packageInfo.version, style: normalLargeTextStyle)
                      .addMarginTop(spacingControl),
                  Text('Follow us on',
                          style: boldLargeTextStyle.copyWith(
                              fontSize: textSizeNormal))
                      .addMarginTop(spacingContainer),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () => {
                        launchURL('https://www.facebook.com/Sdreatech', context)
                      },
                      child: Image.asset(
                        'assets/facebook_icon.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: itemSpacing),
                    InkWell(
                      onTap: () => {
                        launchURL(
                            'https://twitter.com/sdreatech?lang=en', context)
                      },
                      child: Image.asset(
                        'assets/twitter.png',
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(width: itemSpacing),
                    InkWell(
                      onTap: () => {
                        launchURL('https://www.instagram.com/sdreatech/?hl=en',
                            context)
                      },
                      child: Image.asset(
                        'assets/instagram.png',
                        height: 35,
                        width: 35,
                      ),
                    )
                  ]).addMarginTop(12)
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
