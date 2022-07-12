import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soiree/Animation/fadeIn.dart';
import 'package:soiree/widget/carousel.dart';

import '../../utils/pathProvider.dart';
import '../../widget/pictures.dart';

class AddParty extends StatefulWidget {
  final String title = "Ajouter un évènement";
  AddParty({Key key}) : super(key: key);

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


  List<String> _fileUploaded = [];
  String _dateEn = "";

  List<String> _prefTest = ["Fumeur", "Alcool"];
  //List<String> _prefTest = ["Fumeur", "Alcool", "Vegetarien", "Uniquement homme", "Huniquement femme cochon"];
  List<String> _prefSelected = [];

  void dispose(){
    _dateController.dispose();
    super.dispose();
  }


  Future<CameraDescription> getCamera() async {
    final _camera = await availableCameras();
    return _camera.first;
  }



  void removeImage(String path){
    setState(() {
      _fileUploaded.remove(path);
    });
  }

  void addImage(XFile image){
    setState(() {
      _fileUploaded.add(image.path);
    });
  }

  Future<String> _add(){

  }

  List<Widget> _buildChoises(){

    print("start build");


   return _prefTest.map((e) =>  Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
            label: Text(e),

            selectedColor: Colors.blue,
            selected: _prefSelected.contains(e),
            onSelected: (bool selected) {
              if(selected){
                setState(() {
                  _prefSelected.add(e);
                });
              }
              else {
                setState(() {
                  _prefSelected.remove(e);
                });
              }
            }))).toList();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.title),
          titleSpacing: 0.0,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 50.0, left: 50.0),
          child: ListView(

            children: <Widget>[

              _fileUploaded != null && _fileUploaded.isNotEmpty ? Carousel(images: _fileUploaded, removeHandler: this.removeImage).showCarousel(context) : SizedBox(height: 40),

              Form(

                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeIn(
                        1.4,
                        TextFormField(
                          validator: (value) {
                            return null;
                          },
                          controller: _title,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Titre de l'évènement",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 10),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FadeIn(
                        1.4,
                        TextFormField(
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Description de l'évènement",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 10),
                          ),
                          controller: _description,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),FadeIn(
                        1.4,
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Nombre de personnes maximum",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 10),
                          ),
                          controller: null,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FadeIn(
                        1.4,
                        TextFormField(
                          onTap: () async {
                            DateTime now = new DateTime.now();
                            DateTime initialDate = new DateTime.now();
                            if(_dateController.text != "" && DateTime.tryParse(_dateEn) != null){
                              initialDate = DateTime.tryParse(_dateEn);
                            }

                            DateTime last = now.add(Duration(days: 1825));
                            final DateTime selectedDate = await showDatePicker(context: context, initialDate: initialDate, firstDate: now, lastDate: last);


                            if(selectedDate != null){
                              final TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                              if(selectedTime != null){
                                DateTime date = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
                                final frText = new DateFormat("dd/MM/yyyy hh:mm");
                                final enText = new DateFormat("yyyy-MM-dd hh:mm");
                                _dateController.text = frText.format(date);
                                _dateEn = enText.format(date);

                              }
                            }
                          },
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Date de l'évènement",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 10),
                          ),
                          controller: _dateController,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FadeIn(
                        1.4,
                        TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(

                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Lieu de l'évènement",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0,left: 10),
                          ),
                          controller: _street,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      FadeIn(
                        1.4,
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            hintText: "Prix par personne",
                            contentPadding: const EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 10),
                          ),
                          controller: _price,
                        ),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      FadeIn(
                          1.4,

                          Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(

                                      width: 200,
                                      height: 55,

                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                                        ),
                                        onPressed: () async {
                                          FilePickerResult result = await FilePicker.platform.pickFiles(type:FileType.custom, allowMultiple: true, allowedExtensions: ['jpg', 'pdf', 'png']);

                                          //SI image importé
                                          if(result != null){
                                            setState(() {
                                              if(_fileUploaded == null){
                                                _fileUploaded = [];
                                              }
                                              _fileUploaded.addAll(result.files.map((e) => e.path));

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
                                      )
                                  ),
                                  SizedBox(width: 8),
                                  FutureBuilder(
                                    builder: (ctx, snapshot) {

                                      if(snapshot.hasData){
                                        // Displaying LoadingSpinner to indicate waiting state
                                        return TakePicture(
                                          camera: snapshot.data,
                                          key: _key,
                                          addHandler: addImage,
                                        );
                                      }
                                      else{
                                        return Container(width: 0, height: 0);
                                      }

                                    },

                                    // Future that needs to be resolved
                                    // inorder to display something on the Canvas
                                    future: getCamera(),
                                  ),
                                ],
                              )

                          )

                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Wrap(
                              children: _buildChoises(),
                            )
                          ],
                        ),
                      ),


                      SizedBox(
                        height: 10.0,
                      ),
                      FadeIn(
                        2.0,
                        InkWell(
                          child: Container(
                            height: 45.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.grey[300],
                              color: Colors.white,
                              borderOnForeground: false,
                              elevation: 5.0,
                              child: GestureDetector(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "Ajouter",
                                        style: TextStyle(
                                          fontFamily: 'Alatsi',
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            print("Form send");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  )
              ),

            ],
          )

        )
    );
  }

}

