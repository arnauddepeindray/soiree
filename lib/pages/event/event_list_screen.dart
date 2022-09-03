/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:soiree/pages/event/search_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/extension_widget.dart';
import 'package:soiree/Animation/slide_right_route.dart';
import 'package:soiree/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../style/dimens.dart';
import '../../style/theme.dart';
import 'event_details_screen.dart';
import 'filter_screen.dart';

class EventListScreen extends StatefulWidget {
  final String? title;

  const EventListScreen({Key? key, this.title}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<String> eventList = [
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg',
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg',
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg',
    'assets/event_a.jpg',
    'assets/event_b.jpg',
    'assets/event_c.jpg',
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
          appBar: toolbarBack(widget.title!, context),
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
              child: LayoutBuilder(
                builder: (context, dimens) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Colors.white,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  width: context.width,
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: TextFormField(
                                          style: mediumTextStyle,
                                          cursorColor: primaryColor,
                                          decoration: InputDecoration(
                                              hintText: 'Search event',
                                              enabled: false,
                                              border: InputBorder.none,
                                              hintStyle: mediumTextStyle))
                                      .wrapPadding(
                                          padding: const EdgeInsets.only(
                                              left: spacingContainer,
                                              right: spacingContainer)),
                                ),
                              ).wrapPadding(
                                  padding: const EdgeInsets.only(
                                      top: spacingContainer,
                                      right: spacingControl,
                                      bottom: spacingContainer)),
                              onTap: () => Navigator.of(context).push(
                                  SlideRightRoute(page: const SearchScreen())),
                            ),
                          ),
                          GestureDetector(
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.filter_list_rounded,
                                  color: primaryColor,
                                  size: 32,
                                ).wrapPaddingAll(spacingStandard),
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(
                                SlideRightRoute(page: const FilterScreen())),
                          )
                        ],
                      ),
                      GridView.builder(
                        itemCount: 15,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: dimens.maxWidth >
                                        kTabletBreakpoint &&
                                    dimens.maxWidth <= kDesktopBreakPoint
                                ? 2
                                : 1,
                            crossAxisSpacing: 16,
                            childAspectRatio:
                                dimens.maxWidth > kTabletBreakpoint &&
                                        dimens.maxWidth <= kDesktopBreakPoint
                                    ? (dimens.maxWidth /
                                        (widget.title != "Free Events"
                                            ? 800.0
                                            : 700.0))
                                    : (dimens.maxWidth /
                                        (widget.title != "Free Events"
                                            ? 400.0
                                            : 350)),
                            mainAxisSpacing: 16),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('29th Nov, 2020 12:00 PM',
                                          style: mediumTextStyle),
                                      const SizedBox(height: spacingStandard),
                                      Text('Flutter Conference, Dart Analysis',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: boldLargeTextStyle.copyWith(
                                              fontSize: textSizeNormal)),
                                      const SizedBox(height: spacingStandard),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/location.png',
                                              height: 20, width: 20),
                                          Text('New York, US 10010',
                                                  style: mediumTextStyle)
                                              .addMarginLeft(spacingControl),
                                        ],
                                      ),
                                      widget.title != "Free Events"
                                          ? const SizedBox(
                                              height: spacingStandard)
                                          : Container(),
                                      widget.title != "Free Events"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                          itemCount: attendeesList
                                                              .length,
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection: Axis
                                                              .horizontal,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return index ==
                                                                    attendeesList
                                                                            .length -
                                                                        1
                                                                ? Align(
                                                                    widthFactor:
                                                                        0.7,
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[700],
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(50)),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.white,
                                                                          width:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            32.0),
                                                                    child:
                                                                        Align(
                                                                      widthFactor:
                                                                          0.7,
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child: Image
                                                                          .asset(
                                                                        attendeesList[
                                                                            index],
                                                                        width:
                                                                            40,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  );
                                                          })
                                                      .wrapPadding(
                                                          padding: const EdgeInsets
                                                                  .only(
                                                              left:
                                                                  spacingContainer,
                                                              right:
                                                                  spacingStandard)),
                                                ),
                                                Ink(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 100,
                                                            minHeight: 40),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '500 €',
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: boldLargeTextStyle
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container()
                                    ],
                                  ).wrapPadding(
                                      padding: const EdgeInsets.only(
                                          top: spacingLarge * 3.5,
                                          left: spacingContainer,
                                          right: spacingContainer,
                                          bottom: spacingLarge)),
                                ).wrapPadding(
                                    padding: const EdgeInsets.only(
                                        top: spacingLarge * 2.8)),
                                Positioned(
                                  top: 0,
                                  left: 24,
                                  right: 24,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(eventList[index],
                                        width: context.width,
                                        height: 190,
                                        fit: BoxFit.cover),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(SlideRightRoute(
                                  page: const EventDetailsScreen()));
                            },
                          );
                        },
                      ),
                    ],
                  ).wrapPadding(
                      padding: const EdgeInsets.only(
                          right: spacingContainer,
                          left: spacingContainer,
                          bottom: spacingContainer));
                },
              ),
            ),
          )),
    );
  }
}
