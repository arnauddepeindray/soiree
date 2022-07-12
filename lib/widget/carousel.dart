


import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class Carousel extends InheritedWidget {

  Carousel({Key key, this.images, this.removeHandler});
  List<String> images;
  var removeHandler;

  static Carousel of(BuildContext context){
    final Carousel result = context.dependOnInheritedWidgetOfExactType<Carousel>();
    return result;
  }

  @override
  Widget showCarousel(BuildContext context) {
      return images != null ? Container(
          child: Column(
            children: <Widget>[

               CarouselSlider(
                  options: CarouselOptions(height: 255.0),
                  items: images.map((i) {

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                //color: Colors.white
                            ),
                            child: FittedBox(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Image.file(File(i), height: 200),
                                      Padding(
                                          padding: const EdgeInsets.only(top:5.0),
                                          child: MaterialButton(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side: BorderSide(color: Colors.grey)),
                                              height: 5,
                                              child:Icon(Icons.close, color: Colors.red),
                                              onPressed: () {
                                                print("Need deleting :" + i);
                                                this.removeHandler(i);
                                              }
                                          )
                                      )
                                    ],
                                  ),

                                ),



                        );
                      },
                    );
                  }).toList()
              ),
              SizedBox(height: 20)
            ],
          )
      ) : Container(width: 0,height: 0);

  }

  @override
  bool updateShouldNotify(Carousel carousel) => carousel.images != images;

}