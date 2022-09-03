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
import 'package:soiree/widget/text_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class NumberList {
  String? number;
  int? index;

  NumberList({this.number, this.index});
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController dobController = TextEditingController();
  DateTime? selectDate = DateTime.now();
  int id = 1;

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
          appBar: toolbarBack("Profile", context),
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: spacingContainer),
                            Text('Personal Details',
                                style: boldLargeTextStyle.copyWith(
                                    fontSize: textSizeNormal)),
                            const SizedBox(height: spacingContainer),
                            Text("First Name", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            const TextFormWidget(hintText: "Enter First Name"),
                            const SizedBox(height: spacingContainer),
                            Text("Last Name", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            const TextFormWidget(hintText: "Enter Last Name"),
                            const SizedBox(height: spacingContainer),
                            Text("Email", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            const TextFormWidget(
                                hintText: "Enter Email Address"),
                            const SizedBox(height: spacingContainer),
                            Text("Mobile No.", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            const TextFormWidget(hintText: "Enter Mobile No."),
                            const SizedBox(height: spacingContainer),
                            Text("Date Of Birth", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            InkWell(
                              child: TextFormWidget(
                                  textEditingController: dobController,
                                  hintText: "Enter Date Of Birth",
                                  readOnly: false),
                              onTap: () {
                                _selectToDate(context);
                              },
                            ),
                            const SizedBox(height: spacingContainer),
                            Text("Gender", style: smallNormalTextStyle)
                                .addMarginLeft(spacingContainer),
                            _radioGroup()
                          ],
                        ).wrapPadding(
                            padding: const EdgeInsets.only(
                                top: spacingLarge * 3.5,
                                left: spacingContainer,
                                right: spacingContainer,
                                bottom: spacingContainer)),
                      ).wrapPadding(
                          padding:
                              const EdgeInsets.only(top: spacingLarge * 2.5)),
                      Positioned(
                        top: 0,
                        left: 24,
                        right: 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image.asset('assets/man_profile.jpg',
                                    width: context.width,
                                    height: 190,
                                    fit: BoxFit.cover),
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  height: 35,
                                ),
                                Positioned(
                                  bottom: 4,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.edit,
                                            color: Colors.white),
                                        Text('Edit',
                                                style: boldTextStyle.copyWith(
                                                    color: Colors.white))
                                            .addMarginLeft(spacingControl)
                                      ]),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: spacingContainer),
                  Card(
                    color: Colors.white,
                    elevation: elevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address Details',
                            style: boldLargeTextStyle.copyWith(
                                fontSize: textSizeNormal)),
                        const SizedBox(height: spacingContainer),
                        Text("Address 1", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Address 1"),
                        const SizedBox(height: spacingContainer),
                        Text("Address 2", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Address 2"),
                        const SizedBox(height: spacingContainer),
                        Text("Mobile No.", style: smallNormalTextStyle)
                            .addMarginLeft(spacingContainer),
                        const TextFormWidget(hintText: "Enter Mobile No."),
                        const SizedBox(height: spacingContainer),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("City", style: smallNormalTextStyle)
                                          .addMarginLeft(spacingContainer),
                                      const TextFormWidget(
                                          hintText: "Enter City"),
                                    ]),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("State", style: smallNormalTextStyle)
                                          .addMarginLeft(spacingContainer),
                                      const TextFormWidget(
                                          hintText: "Enter State"),
                                    ]),
                              )
                            ]),
                        const SizedBox(height: spacingContainer),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Country",
                                              style: smallNormalTextStyle)
                                          .addMarginLeft(spacingContainer),
                                      const TextFormWidget(
                                          hintText: "Enter Country"),
                                    ]),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pin Code",
                                              style: smallNormalTextStyle)
                                          .addMarginLeft(spacingContainer),
                                      const TextFormWidget(
                                          hintText: "Enter Pin Code"),
                                    ]),
                              )
                            ]),
                        const SizedBox(height: spacingContainer)
                      ],
                    ).wrapPaddingAll(spacingContainer),
                  ),
                  const SizedBox(height: spacingLarge),
                  const ButtonWidget(text: "Update"),
                  const SizedBox(height: spacingContainer),
                ],
              ).wrapPaddingAll(spacingContainer),
            ),
          )),
    );
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 150),
        lastDate: DateTime.now(),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
    if (d != null) {
      setState(() {
        selectDate = d;
        dobController.text = DateFormat("dd-MM-yyyy").format(selectDate!);
      });
    }
  }

  _radioGroup() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (int? value) {
                setState(() {
                  id = value!;
                });
              },
              fillColor: MaterialStateProperty.all(primaryColor),
            ),
            Text("Male", style: boldTextStyle)
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (int? value) {
                setState(() {
                  id = value!;
                });
              },
              fillColor: MaterialStateProperty.all(primaryColor),
            ),
            Text("Female", style: boldTextStyle)
          ],
        ),
        Row(
          children: [
            Radio(
              value: 3,
              groupValue: id,
              onChanged: (int? value) {
                setState(() {
                  id = value!;
                });
              },
              fillColor: MaterialStateProperty.all(primaryColor),
            ),
            Text("Transgender", style: boldTextStyle)
          ],
        )
      ],
    );
  }
}
