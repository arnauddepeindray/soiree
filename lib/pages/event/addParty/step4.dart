import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soiree/style/colors.dart';
import 'package:soiree/widget/pictures.dart';
import 'package:soiree/widget/text_form_widget.dart';

import '../../../widget/carousel.dart';
import 'add.dart';

class Step4 extends StatefulWidget {
  final String title = "Ajouter des photos";
  final int? currentStep;

  const Step4({this.currentStep, super.key});

  @override
  Step4State createState() {
    return Step4State();
  }
}

class Step4State extends State<Step4> {
  String _dateEn = "";
  final int step = 4;

  List<String> _fileUploaded = [];
  final GlobalKey<AddPartyState> _key = GlobalKey();

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

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return step == widget.currentStep
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children:
        <Widget>[
            _fileUploaded.isNotEmpty
                ? Carousel(
                    key: _key,
                    images: _fileUploaded,
                    removeHandler: this.removeImage,
                    child: Builder(
                      builder: (BuildContext innerContext) {
                        Widget? widg =
                            Carousel.of(innerContext)?.showCarousel(context);
                        return widg!;
                      },
                    ))
                : SizedBox(height: 40),
            Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: 200,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.custom,
                                    allowMultiple: true,
                                    allowedExtensions: ['jpg', 'pdf', 'png']);

                            //SI image importé
                            if (result != null) {
                              setState(() {
                                if (_fileUploaded == null) {
                                  _fileUploaded = [];
                                }
                                _fileUploaded.addAll(
                                    result.files.map((e) => e.path.toString()));
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(width: 8),
                    FutureBuilder(
                      builder: (ctx, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // Displaying LoadingSpinner to indicate waiting state
                          return TakePicture(
                            camera: snapshot.data,
                            key: _key,
                            addHandler: addImage,
                          );
                        } else {
                          return Container(width: 0, height: 0);
                        }
                      },

                      // Future that needs to be resolved
                      // inorder to display something on the Canvas
                      future: getCamera(),
                    ),
                  ],
                ))
          ])
        : Ink();
  }
}
