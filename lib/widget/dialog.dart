import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, title, message) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Fermer"),
    onPressed: () => Navigator.pop(context, 'Cancel'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
