import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soiree/pages/event/event_added_screen.dart';
import 'package:soiree/utils/extension.dart';
import 'package:soiree/widget/carousel.dart';

import '../../Animation/slide_right_route.dart';
import '../../style/colors.dart';
import '../../style/dimens.dart';
import '../../utils/extension_widget.dart';
import '../../utils/pathProvider.dart';
import '../../widget/button_widget.dart';
import '../../widget/pictures.dart';
import '../../widget/text_form_widget.dart';

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
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _number_allow = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final db = FirebaseFirestore.instance;
  List<String> _fileUploaded = [];
  String _dateEn = "";

  List<Map> _prefTest = [];
  List<String> _prefSelected = [];

  String? _idAdded;

  void dispose() {
    _dateController.dispose();
    _title.dispose();
    _description.dispose();
    _street.dispose();
    _number_allow.dispose();
    _price.dispose();
    super.dispose();
  }

  Future<CameraDescription> getCamera() async {
    final _camera = await availableCameras();
    return _camera.first;
  }

  void removeImage(String path) {
    setState(() {
      _fileUploaded.remove(path);
    });
  }

  void addImage(XFile image) {
    setState(() {
      _fileUploaded.add(image.path);
    });
  }

  Future<void> getPref() async {
    db.collection("preferences").get().then((event) {
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

  Future<void> _add() async {
    List<Map> _prefsToAdd = [];
    _prefSelected.forEach((pref) {
      var entries = <String, dynamic>{"pref_party": pref};
      _prefsToAdd.add(entries);
    });

    final party = <String, dynamic>{
      "address": _street.text,
      "date": _dateController.text,
      "description": _description.text,
      "number_people": _number_allow.text,
      "title": _title.text,
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
      return;
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
                }
              }));
    }).toList();
    return widgets;
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
                            _fileUploaded.isNotEmpty
                                ? Carousel(
                                    key: _key,
                                    images: _fileUploaded,
                                    removeHandler: this.removeImage,
                                    child: Builder(
                                      builder: (BuildContext innerContext) {
                                        Widget? widg = Carousel.of(innerContext)
                                            ?.showCarousel(context);
                                        return widg!;
                                      },
                                    ))
                                : SizedBox(height: 40),
                            Form(
                                key: _formKey,
                                child: Column(
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
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
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
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormWidget(
                                      hintText: "Prix par personne",
                                      textInputType: TextInputType.number,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 200,
                                                height: 55,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        primary: primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                  ),
                                                  onPressed: () async {
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles(
                                                                type: FileType
                                                                    .custom,
                                                                allowMultiple:
                                                                    true,
                                                                allowedExtensions: [
                                                          'jpg',
                                                          'pdf',
                                                          'png'
                                                        ]);

                                                    //SI image importé
                                                    if (result != null) {
                                                      setState(() {
                                                        if (_fileUploaded ==
                                                            null) {
                                                          _fileUploaded = [];
                                                        }
                                                        _fileUploaded.addAll(
                                                            result.files.map(
                                                                (e) => e.path
                                                                    .toString()));
                                                      });
                                                    }
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Ajouter des images",
                                                        style: TextStyle(
                                                          fontFamily: 'Alatsi',
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(width: 8),
                                            FutureBuilder(
                                              builder: (ctx,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  // Displaying LoadingSpinner to indicate waiting state
                                                  return TakePicture(
                                                    camera: snapshot.data,
                                                    key: _key,
                                                    addHandler: addImage,
                                                  );
                                                } else {
                                                  return Container(
                                                      width: 0, height: 0);
                                                }
                                              },

                                              // Future that needs to be resolved
                                              // inorder to display something on the Canvas
                                              future: getCamera(),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        child: FutureBuilder<List<Widget>>(
                                      future: _buildChoises(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<Widget>>
                                              snapshot) {
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
                                          children = <Widget>[
                                            SizedBox(width: 0, height: 0)
                                          ];
                                        } else {
                                          children = <Widget>[
                                            SizedBox(width: 0, height: 0)
                                          ];
                                        }

                                        return Container(
                                            width: 350,
                                            child: Row(children: children));
                                      },
                                    )),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    InkWell(
                                      child: InkWell(
                                        child: const ButtonWidget(text: "Ajouter")
                                            .wrapPaddingAll(spacingContainer),
                                        onTap: () async {
                                          await _add();
                                          if (_idAdded != null) {
                                            Navigator.of(context).push(
                                                SlideRightRoute(page: const EventAddedScreen()));
                                          } else {
                                            print("error");
                                          }
                                          ;
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
