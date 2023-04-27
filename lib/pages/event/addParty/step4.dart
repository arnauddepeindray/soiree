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
  final GlobalKey<FormState>? formKey;
  final Function onSave;

  const Step4({this.formKey, required this.onSave, super.key});

  @override
  Step4State createState() {
    return Step4State();
  }
}

class Step4State extends State<Step4> {
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
    widget.onSave(_fileUploaded);
  }

  void addImage(XFile image) {
    setState(() {
      _fileUploaded.add(image.path);
    });
    widget.onSave(_fileUploaded);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                : SizedBox(height: 0),
            Container(
                alignment: Alignment.center,
                child: Flexible(
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: primaryColor,
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
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 65,
                      ),
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
                  ),
                ))
          ]),
    );
  }
}
