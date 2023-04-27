import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soiree/widget/text_form_widget.dart';

class Step2 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController dateController;
  final TextEditingController street;

  const Step2(
      {super.key,
      required this.formKey,
      required this.dateController,
      required this.street});

  @override
  Widget build(BuildContext context) {
    String _dateEn = "";

    void _dateTap() async {
      DateTime? now = new DateTime.now();
      DateTime? initialDate = new DateTime.now();
      if (dateController.text != "" && DateTime.tryParse(_dateEn) != null) {
        initialDate = DateTime.tryParse(_dateEn);
      }

      DateTime last = now.add(Duration(days: 1825));
      final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate!,
          firstDate: now,
          lastDate: last);

      if (selectedDate != null) {
        final TimeOfDay? selectedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (selectedTime != null) {
          DateTime date = new DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute);
          final frText = new DateFormat("dd/MM/yyyy hh:mm");
          final enText = new DateFormat("yyyy-MM-dd hh:mm");
          dateController.text = frText.format(date);
          _dateEn = enText.format(date);
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormWidget(
              hintText: "Date de l'évènement",
              textInputType: TextInputType.none,
              textEditingController: dateController,
              onTap: () => _dateTap(),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormWidget(
              hintText: "Lieu de l'évènement",
              textEditingController: street,
              textInputType: TextInputType.streetAddress,
            )
          ]),
    );
  }
}
