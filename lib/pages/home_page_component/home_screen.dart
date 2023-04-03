/*
 * *
 *  * Created by Vishal Patolia on 9/28/21, 1:39 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/23/21, 12:19 PM
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soiree/data/category.dart';
import 'package:soiree/data/party.dart';
import 'package:soiree/pages/drawer/drawer.dart';
import 'package:soiree/pages/event/addParty/add.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/utils/widgetProvider.dart';

import '../../Animation/slide_right_route.dart';
import '../../style/colors.dart';
import '../../style/dimens.dart';
import '../../style/theme.dart';
import '../event/event_details_screen.dart';
import '../event/event_list_screen.dart';
import '../event/filter_screen.dart';
import '../event/my_event_screen.dart';
import '../event/past_event_screen.dart';
import '../event/search_screen.dart';
import '../feedback/feedback_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/contact_us_screen.dart';
import '../setting/help_screen.dart';
import '../setting/settings_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600));
  final db = FirebaseFirestore.instance;
  List<Categories> categoriesList = [];
  List<String> eventList = [];

  void _getCategories () async{
    db.collection("preferences").get().then((event) {
      List<Categories> tmpCategories = [];
      for (var doc in event.docs) {
        Categories categories = Categories(doc.get("name"), false);
        tmpCategories.add(categories);
      }

      setState(() {
        categoriesList = tmpCategories;
      });
    });

  }

  void _getEvents () async {

  }



  List<String> attendeesList = [
  ];



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    _getCategories();
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(150.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(_animationController),
                        child: const Center(child: Icon(Icons.menu, size: 32)),
                      ),
                    ),
                    onTap: () {
                      _animationController.forward(from: 0.0);
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                  WidgetProvider(name: "add_party-Icon"),
                  InkWell(
                    child: const Icon(Icons.notifications_none_rounded,
                        color: primaryColor, size: 32),
                    onTap: () => {
                      Navigator.of(context).push(
                          SlideRightRoute(page: const NotificationScreen()))
                    },
                  )
                ],
              ).wrapPaddingAll(spacingContainer)),
          drawer: DrawerScreen(),
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
                  Text('Welcome Mario,',
                      style:
                          boldLargeTextStyle.copyWith(fontSize: textSizeLarge)),
                  const SizedBox(height: spacingContainer),
                  Text('Find trending events', style: normalTextStyle),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
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
                        onTap: () => Navigator.of(context)
                            .push(SlideRightRoute(page: const FilterScreen())),
                      )
                    ],
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Categories',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const Icon(Icons.more_horiz_rounded,
                            color: primaryColor, size: 32)
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                          SlideRightRoute(page: const CategoriesScreen()));
                    },
                  ),
                  const SizedBox(height: spacingContainer),
                  SizedBox(
                    height: 50,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: ListView.separated(
                          itemCount: categoriesList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: spacingStandard);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: categoriesList[index].isSelect == true
                                      ? primaryColor
                                      : backgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(categoriesList[index].catName!,
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              categoriesList[index].isSelect ==
                                                      true
                                                  ? boldTextStyle.copyWith(
                                                      color: Colors.white)
                                                  : boldTextStyle)
                                      .wrapPaddingAll(12),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (categoriesList[index].isSelect == true) {
                                    categoriesList[index].isSelect = false;
                                  } else {
                                    categoriesList[index].isSelect = true;
                                  }
                                });
                              },
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Popular Events',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const Icon(Icons.more_horiz_rounded,
                            color: primaryColor, size: 32)
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(SlideRightRoute(
                          page:
                              const EventListScreen(title: "Popular Events")));
                    },
                  ),
                  const SizedBox(height: spacingContainer),
                  SizedBox(
                    height: 360,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: ListView.separated(
                          itemCount: eventList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: spacingContainer);
                          },
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
                                    child: SizedBox(
                                      width: 270,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('29th Nov, 2020 12:00 PM',
                                              style: normalTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
                                          Text(
                                              'Flutter Conference, Dart Analysis',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: boldLargeTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
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
                                                  .addMarginLeft(
                                                      spacingControl),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: spacingStandard),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                                              .grey[
                                                                          700],
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              50)),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    width: 40,
                                                                    height: 40,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              32.0),
                                                                  child: Align(
                                                                    widthFactor:
                                                                        0.7,
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: Image
                                                                        .asset(
                                                                      attendeesList[
                                                                          index],
                                                                      width: 40,
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
                                                decoration: const BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 80,
                                                          minHeight: 40),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '500',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        boldTextStyle.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ).wrapPadding(
                                          padding: const EdgeInsets.only(
                                              top: spacingLarge * 3,
                                              left: spacingContainer,
                                              right: spacingContainer,
                                              bottom: spacingContainer)),
                                    ),
                                  ).wrapPadding(
                                      padding: const EdgeInsets.only(
                                          top: spacingLarge * 2)),
                                  Positioned(
                                    top: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(eventList[index],
                                          width: 230, fit: BoxFit.scaleDown),
                                    ),
                                  )
                                ],
                              ).wrapPadding(
                                  padding: const EdgeInsets.only(
                                      bottom: spacingContainer)),
                              onTap: () {
                                Navigator.of(context).push(SlideRightRoute(
                                    page: const EventDetailsScreen()));
                              },
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Latest Events',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const Icon(Icons.more_horiz_rounded,
                            color: primaryColor, size: 32)
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(SlideRightRoute(
                          page: const EventListScreen(title: "Latest Events")));
                    },
                  ),
                  const SizedBox(height: spacingContainer),
                  SizedBox(
                    height: 360,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: ListView.separated(
                          itemCount: eventList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: spacingContainer);
                          },
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
                                    child: SizedBox(
                                      width: 270,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('29th Nov, 2020 12:00 PM',
                                              style: normalTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
                                          Text(
                                              'Flutter Conference, Dart Analysis',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: boldLargeTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
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
                                                  .addMarginLeft(
                                                      spacingControl),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: spacingStandard),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                                              .grey[
                                                                          700],
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              50)),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    width: 40,
                                                                    height: 40,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              32.0),
                                                                  child: Align(
                                                                    widthFactor:
                                                                        0.7,
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: Image
                                                                        .asset(
                                                                      attendeesList[
                                                                          index],
                                                                      width: 40,
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
                                                decoration: const BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 80,
                                                          minHeight: 40),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '500',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        boldTextStyle.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ).wrapPadding(
                                          padding: const EdgeInsets.only(
                                              top: spacingLarge * 3,
                                              left: spacingContainer,
                                              right: spacingContainer,
                                              bottom: spacingContainer)),
                                    ),
                                  ).wrapPadding(
                                      padding: const EdgeInsets.only(
                                          top: spacingLarge * 2)),
                                  Positioned(
                                    top: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(eventList[index],
                                          width: 230, fit: BoxFit.scaleDown),
                                    ),
                                  )
                                ],
                              ).wrapPadding(
                                  padding: const EdgeInsets.only(
                                      bottom: spacingContainer)),
                              onTap: () {
                                Navigator.of(context).push(SlideRightRoute(
                                    page: const EventDetailsScreen()));
                              },
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: spacingContainer),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Free Events',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const Icon(Icons.more_horiz_rounded,
                            color: primaryColor, size: 32)
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(SlideRightRoute(
                          page: const EventListScreen(title: "Free Events")));
                    },
                  ),
                  const SizedBox(height: spacingContainer),
                  SizedBox(
                    height: 320,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: ListView.separated(
                          itemCount: eventList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: spacingContainer);
                          },
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
                                    child: SizedBox(
                                      width: 270,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('29th Nov, 2020 12:00 PM',
                                              style: normalTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
                                          Text(
                                              'Flutter Conference, Dart Analysis',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: boldLargeTextStyle),
                                          const SizedBox(
                                              height: spacingStandard),
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
                                                  .addMarginLeft(
                                                      spacingControl),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: spacingStandard),
                                        ],
                                      ).wrapPadding(
                                          padding: const EdgeInsets.only(
                                              top: spacingLarge * 3,
                                              left: spacingContainer,
                                              right: spacingContainer,
                                              bottom: spacingContainer)),
                                    ),
                                  ).wrapPadding(
                                      padding: const EdgeInsets.only(
                                          top: spacingLarge * 2)),
                                  Positioned(
                                    top: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(eventList[index],
                                          width: 230, fit: BoxFit.scaleDown),
                                    ),
                                  )
                                ],
                              ).wrapPadding(
                                  padding: const EdgeInsets.only(
                                      bottom: spacingContainer)),
                              onTap: () {
                                setState(() {});
                              },
                            );
                          }),
                    ),
                  )
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }


}


