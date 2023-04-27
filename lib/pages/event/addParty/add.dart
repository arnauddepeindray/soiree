import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:soiree/data/party.dart';
import 'package:soiree/pages/event/addParty/step1.dart';
import 'package:soiree/pages/event/addParty/step2.dart';
import 'package:soiree/pages/event/addParty/step3.dart';
import 'package:soiree/pages/event/addParty/step4.dart';
import 'package:soiree/widget/my_stepper.dart';

import '../../../style/colors.dart';
import '../../../utils/extension_widget.dart';

class AddParty extends StatefulWidget {
  final String title = "Ajouter un évènement";

  AddParty({super.key});

  @override
  AddPartyState createState() {
    return AddPartyState();
  }

  static AddPartyState? of(BuildContext context) =>
      context.findAncestorStateOfType<AddPartyState>();
}

class AddPartyState extends State<AddParty> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AddPartyState> _key = GlobalKey();
  final db = FirebaseFirestore.instance;

  //Paramètre du multistep
  List<GlobalKey<FormState>> _listStepKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

//Liste des champs
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _number_allow = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _price = TextEditingController();
  List<String> _prefSelected = [];
  List<String> _fileUploaded = [];

  Party _modelParty = new Party();
  String? _idAdded;

  void dispose() {
    _title.dispose();
    _description.dispose();
    _number_allow.dispose();
    _dateController.dispose();
    _street.dispose();
    _price.dispose();
    super.dispose();
  }

  List<Map<String, Widget>> createSteps() {
    return [
      {
        "Votre évènement": Step1(
          formKey: _listStepKey[0],
          title: _title,
          description: _description,
          number_allow: _number_allow,
        )
      },
      {
        "Détails de votre événement": Step2(
          formKey: _listStepKey[1],
          dateController: _dateController,
          street: _street,
        )
      },
      {
        "Vos préférences": Step3(
            formKey: _listStepKey[2],
            price: _price,
            onSave: handleSavePref,
            db: db)
      },
      {
        "Ajouter des photos": Step4(
          formKey: _listStepKey[3],
          onSave: handleSaveImages,
        )
      }
    ];
  }

  //Event multistep

  // Sauvegarde des préférences selectionnés
  void handleSavePref(List<String> prefSelected) {
    setState(() {
      _prefSelected = prefSelected;
    });
  }

  // Sauvegarde des images uploadé
  void handleSaveImages(List<String> upload) {
    setState(() {
      _fileUploaded = upload;
    });
  }

  // Ajout de l'évènement
  Future<void> _add() async {
    print("Submit test" + _title.text);
    List<Map> _prefsToAdd = [];

    _prefSelected.forEach((pref) {
      var entries = <String, dynamic>{"pref_party": pref};
      _prefsToAdd.add(entries);
    });

    final party = <String, dynamic>{
      "address": _street.text, //_street.text,
      "date": _dateController.text, //_dateController.text,
      "description": _description.text,
      "number_people": _number_allow.text,
      "title": _title.text,
      "price": _price.text,
    };

    db.collection("party").add(party).then((DocumentReference doc) {
      _prefsToAdd.forEach((dynamic e) {
        db.collection("party").doc(doc.id).collection("preferences").add(e);
      });

      int num = 0;

      _fileUploaded.forEach((e) async {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("party_images")
            .child("party${num}-${doc.id}.jpg");

        final metadata = SettableMetadata(
            contentType: 'image/jpeg', customMetadata: {'picked-file-path': e});

        ref.putData(await File(e).readAsBytes(), metadata);

        db
            .collection("party")
            .doc(doc.id)
            .collection("images")
            .add(<String, dynamic>{"name": "party${num}-${doc.id}.jpg"});

        num++;
      });

      setState(() {
        _idAdded = doc.id;
      });
    }).onError((error, stackTrace) {
      print("Error on create ");
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: toolbarBack(widget.title, context),
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
                  child: Container(
                      margin: EdgeInsets.only(right: 50.0, left: 5.0),
                      child: Column(
                        children: <Widget>[
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: StepperBuilder(
                              onSubmit: _add,
                              listStepKey: _listStepKey,
                              listSteps: createSteps(),
                            ),
                          )
                        ],
                      )),
                ))));
  }
}
