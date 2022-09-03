/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soiree/utils/extension.dart';

import '../../Animation/slide_right_route.dart';
import '../../style/colors.dart';
import '../../style/dimens.dart';
import '../../style/theme.dart';
import '../../utils/extension_widget.dart';
import 'attendees_profile_screen.dart';

class AttendeesScreen extends StatefulWidget {
  const AttendeesScreen({Key? key}) : super(key: key);

  @override
  _AttendeesScreenState createState() => _AttendeesScreenState();
}

class _AttendeesScreenState extends State<AttendeesScreen> {
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
          appBar: toolbarBack("Attendees", context),
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
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: 50,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset('assets/man.png',
                                  height: 120, fit: BoxFit.scaleDown),
                            ),
                            Text('Mario', style: mediumTextStyle)
                                .addMarginTop(spacingControl)
                          ],
                        ),
                        onTap: () => Navigator.of(context).push(SlideRightRoute(
                            page: const AttendeesProfileScreen())));
                  }).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
