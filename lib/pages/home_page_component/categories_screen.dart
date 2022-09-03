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

import '../../data/category.dart';
import '../../style/colors.dart';
import '../../style/dimens.dart';
import '../../style/theme.dart';
import '../../utils/extension_widget.dart';
import '../../widget/button_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Categories> categoriesList = [

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
          appBar: toolbarBack("Categories", context),
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
                  GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2.8,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: categoriesList.length,
                      semanticChildCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: categoriesList[index].isSelect == true
                                  ? primaryColor
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
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
                                          categoriesList[index].isSelect == true
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
                  const SizedBox(height: spacingLarge),
                  InkWell(
                    child: const ButtonWidget(text: "Save"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }
}
