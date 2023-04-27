import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soiree/widget/text_form_widget.dart';

class Step3 extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController price;
  final Function onSave;

  final FirebaseFirestore? db;
  const Step3(
      {this.formKey,
      required this.price,
      required this.onSave,
      this.db,
      super.key});

  @override
  Step3State createState() {
    return Step3State();
  }
}

class Step3State extends State<Step3> {
  List<Map> _prefTest = [];
  List<String> _prefSelected = [];

  Future<void> getPref() async {
    widget.db?.collection("preferences").get().then((event) {
      List<Map> prefList = [];
      for (var doc in event.docs) {
        Map<String, String> pref = {};
        var entries = <String, String>{"id": doc.id, "name": doc.get("name")};
        pref.addAll(entries);

        prefList.add(pref);
      }

      setState(() {
        _prefTest = prefList;
      });
    });
  }

  Future<List<Widget>> _buildChoises() async {
    await getPref();
    List<Widget> widgets = _prefTest.map((pref) {
      return Padding(
          padding: const EdgeInsets.all(4.0),
          child: FilterChip(
              label: Text(pref["name"]),
              selectedColor: Colors.blue,
              selected: _prefSelected.contains(pref.values.first),
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    _prefSelected.add(pref.values.first);
                  });
                } else {
                  setState(() {
                    _prefSelected.remove(pref.values.first);
                  });
                  widget.onSave(_prefSelected);
                }
              }));
    }).toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormWidget(
                hintText: "Prix par personne",
                textInputType: TextInputType.number,
                textEditingController: widget.price,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  child: FutureBuilder<List<Widget>>(
                future: _buildChoises(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    List<Widget>? data = snapshot.data;
                    children = <Widget>[
                      Flexible(
                          child: Wrap(
                        direction: Axis.horizontal,
                        children: data!,
                      ))
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[SizedBox(width: 0, height: 0)];
                  } else {
                    children = <Widget>[SizedBox(width: 0, height: 0)];
                  }

                  return Container(width: 350, child: Row(children: children));
                },
              ))
            ]));
  }
}
