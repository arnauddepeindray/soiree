import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soiree/pages/event/addParty/step1.dart';
import 'package:soiree/pages/event/addParty/step2.dart';
import 'package:soiree/pages/event/addParty/step3.dart';
import 'package:soiree/pages/event/addParty/step4.dart';
import 'package:soiree/pages/event/event_added_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/widget/carousel.dart';

import '../../../Animation/slide_right_route.dart';
import '../../../style/colors.dart';
import '../../../style/dimens.dart';
import '../../../utils/extension_widget.dart';
import '../../../utils/pathProvider.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/pictures.dart';
import '../../../widget/text_form_widget.dart';

class AddParty extends StatefulWidget {
  final String title = "Ajouter un évènement";

  AddParty({super.key});

  @override
  AddPartyState createState() {
    return AddPartyState();
  }
}

class AddPartyState extends State<AddParty> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AddPartyState> _key = GlobalKey();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final db = FirebaseFirestore.instance;
  //Paramètre du multistep
  int _currentStep = 1;
  final int maxStep = 4;
  String _nextText = "Suivant";


  String? _idAdded;

  void dispose() {
    _dateController.dispose();
    _street.dispose();
    _price.dispose();
    super.dispose();
  }



  void changeStep(int step){
    setState(() {
      _currentStep = step;
      if(_currentStep == maxStep){
        _nextText = "Ajouter une soirée";
      }
    });
  }



  Future<void> _add() async {
    List<Map> _prefsToAdd = [];
    /* @TODO Récupérer le champs préférence
    _prefSelected.forEach((pref) {
      var entries = <String, dynamic>{"pref_party": pref};
      _prefsToAdd.add(entries);
    });*/

    final party = <String, dynamic>{
      "address": _street.text,
      "date": _dateController.text,
      //@TODO récupérer les champs des autres steps
      //"description": _description.text,
      //"number_people": _number_allow.text,
      //"title": _title.text,
    };

    db.collection("party").add(party).then((DocumentReference doc) {
      _prefsToAdd.forEach((dynamic e) {
        db.collection("party").doc(doc.id).collection("preferences").add(e);
      });

      int num = 0;
      /* @TODO récupérer les champs des autres steps
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
      });*/

      setState(() {
        _idAdded = doc.id;
      });
    }).onError((error, stackTrace) {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {



    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: toolbarBack("Ajouter une soirée", context),
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
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 50.0, left: 50.0),
                        child: Column(
                          children: <Widget>[

                            Form(
                                key: _formKey,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Step1(currentStep: _currentStep),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Step2(currentStep: _currentStep),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Step3(currentStep: _currentStep, db: db),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    Step4(currentStep: _currentStep),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      child: InkWell(
                                        child:  ButtonWidget(
                                            text: _nextText)
                                            .wrapPaddingAll(spacingContainer),
                                        onTap: () async {

                                          //Si on est pas à la fin du step alors on affiche l'étape suivante
                                          if(_currentStep < maxStep){
                                            changeStep(_currentStep+1);
                                            print(_currentStep);
                                          }

                                          else{
                                            await _add();
                                            if (_idAdded != null) {
                                              Navigator.of(context).push(
                                                  SlideRightRoute(page: const EventAddedScreen()));
                                            } else {
                                              print("error");
                                            }
                                          };
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                )),
                          ],
                        ))))));
  }
}
