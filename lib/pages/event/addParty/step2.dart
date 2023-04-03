import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soiree/widget/text_form_widget.dart';

class Step2 extends StatefulWidget {
  final String title = "Informations de vôtre événement";
  final int? currentStep;
  const Step2({
    this.currentStep,
    super.key});

  @override
  Step2State createState() {
    return Step2State();
  }
}

class Step2State extends State<Step2> {

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _street = TextEditingController();
  String _dateEn = "";
  final int step = 2;
  void dispose() {
    _dateController.dispose();
    _street.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _dateTap() async {
      DateTime? now = new DateTime.now();
      DateTime? initialDate = new DateTime.now();
      if (_dateController.text != "" && DateTime.tryParse(_dateEn) != null) {
        initialDate = DateTime.tryParse(_dateEn);
      }

      DateTime last = now.add(Duration(days: 1825));
      final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate!,
          firstDate: now,
          lastDate: last);

      if (selectedDate != null) {
        final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

        if (selectedTime != null) {
          DateTime date = new DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute);
          final frText = new DateFormat("dd/MM/yyyy hh:mm");
          final enText = new DateFormat("yyyy-MM-dd hh:mm");
          _dateController.text = frText.format(date);
          _dateEn = enText.format(date);
        }
      }
    }

    return step == widget.currentStep ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormWidget(

            hintText: "Date de l'évènement",
            textInputType: TextInputType.none,
            textEditingController: _dateController,
            onTap: () => _dateTap(),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormWidget(
            hintText: "Lieu de l'évènement",
            textInputType:
            TextInputType.streetAddress,
          )
        ]) : Ink();
  }
}
