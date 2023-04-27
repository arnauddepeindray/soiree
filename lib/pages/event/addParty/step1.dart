import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soiree/widget/text_form_widget.dart';
import 'package:soiree/validator/generics.dart';

import 'add.dart';

class Step1 extends StatelessWidget with GenericValidator {
  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController number_allow;

  final GlobalKey<FormState>? formKey;

  const Step1(
      {super.key,
      this.formKey,
      required this.title,
      required this.description,
      required this.number_allow});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormWidget(
              hintText: "Titre de l'évenement",
              textEditingController: title,
              onValidation: (value) {
                if (isEmpty(value)) {
                  return "Le titre est requis";
                }

                return null;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormWidget(
              hintText: "Description de l'évènement",
              textEditingController: description,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormWidget(
              hintText: "Nombre de personnes maximum",
              textInputType: TextInputType.number,
              textEditingController: number_allow,
            )
          ]),
    );
  }
}
