/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:soiree/pages/attendees/attendees_screen.dart';
import 'package:soiree/pages/event/event_view_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyEventScreen extends StatefulWidget {
  const MyEventScreen({Key? key}) : super(key: key);

  @override
  _MyEventScreenState createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  List<String> eventList = [
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg'
  ];

  List<String> attendeesList = [
    'assets/woman.png',
    'assets/man.png',
    'assets/woman_a.png',
    'assets/woman.png',
    'assets/man.png',
    'assets/woman_a.png',
    'assets/woman.png',
    'assets/man.png',
    'assets/woman_a.png'
  ];

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
          appBar: toolbarBack("My Events", context),
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
              child: LayoutBuilder(builder: (context, dimens) {
                return GridView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: dimens.maxWidth > kTabletBreakpoint &&
                              dimens.maxWidth <= kDesktopBreakPoint
                          ? 2
                          : 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: dimens.maxWidth > kTabletBreakpoint &&
                              dimens.maxWidth <= kDesktopBreakPoint
                          ? (dimens.maxWidth / 750.0)
                          : (dimens.maxWidth / 400.0)),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(32.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32)),
                              child: Image.asset(eventList[index],
                                  width: context.width,
                                  height: 180,
                                  fit: BoxFit.fitWidth),
                            ),
                            Text('29th Nov, 2020 12:00 PM',
                                    style: mediumTextStyle)
                                .wrapPadding(
                                    padding: const EdgeInsets.only(
                                        top: spacingContainer,
                                        bottom: spacingControl,
                                        left: spacingContainer,
                                        right: spacingContainer)),
                            Text('Flutter Conference, Dart Analysis',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: boldLargeTextStyle.copyWith(
                                        fontSize: textSizeNormal))
                                .wrapPadding(
                                    padding: const EdgeInsets.only(
                                        bottom: spacingControl,
                                        left: spacingContainer,
                                        right: spacingContainer)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/location.png',
                                    height: 20, width: 20),
                                Text('New York, US 10010',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: mediumTextStyle)
                                    .addMarginLeft(spacingControl),
                              ],
                            ).wrapPadding(
                                padding: const EdgeInsets.only(
                                    bottom: spacingStandard,
                                    left: 14,
                                    right: spacingContainer)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                          itemCount: attendeesList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return index ==
                                                    attendeesList.length - 1
                                                ? Align(
                                                    widthFactor: 0.7,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[700],
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    50)),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      width: 40,
                                                      height: 40,
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                    child: Align(
                                                      widthFactor: 0.7,
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Image.asset(
                                                        attendeesList[index],
                                                        width: 40,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(SlideRightRoute(
                                                              page:
                                                                  const AttendeesScreen()));
                                                    },
                                                  );
                                          })
                                      .wrapPadding(
                                          padding: const EdgeInsets.only(
                                              left: spacingContainer,
                                              right: spacingStandard)),
                                ),
                                InkWell(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 80, minHeight: 40),
                                    decoration: const BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'View',
                                      textAlign: TextAlign.center,
                                      style: boldLargeTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                      SlideRightRoute(
                                          page: const EventViewScreen())),
                                )
                              ],
                            ).wrapPadding(
                                padding: const EdgeInsets.only(
                                    bottom: itemSpacing,
                                    left: 14,
                                    right: spacingContainer)),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    );
                  },
                ).wrapPadding(
                    padding: const EdgeInsets.only(
                        right: spacingContainer,
                        left: spacingContainer,
                        bottom: spacingContainer));
              }),
            ),
          )),
    );
  }
}
