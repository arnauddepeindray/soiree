import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soiree/widget/text_form_widget.dart';

class Step1 extends StatefulWidget {
  final String title = "Informations de vôtre événement";
  final int? currentStep;
  const Step1({
    this.currentStep,
    super.key});

  @override
  Step1State createState() {
    return Step1State();
  }
}

class Step1State extends State<Step1> {

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _number_allow = TextEditingController();
  final int step = 1;
  void dispose() {
    _title.dispose();
    _description.dispose();
    _number_allow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return step == widget.currentStep ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormWidget(
            hintText: "Titre de l'évenement",
            textEditingController: _title,
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormWidget(
            hintText: "Description de l'évènement",
            textEditingController: _description,
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormWidget(
            hintText: "Nombre de personnes maximum",
            textInputType: TextInputType.number,
            textEditingController: _number_allow,
          )
        ]) : Ink();
  }
}
