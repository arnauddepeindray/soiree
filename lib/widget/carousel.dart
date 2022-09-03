import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Carousel extends InheritedWidget {
  Carousel(
      {required Key key,
      required this.images,
      this.removeHandler,
      required super.child});

  List<String> images;
  var removeHandler;

  static Carousel? of(BuildContext context) {
    final Carousel? result =
        context.dependOnInheritedWidgetOfExactType<Carousel>();
    return result;
  }

  @override
  Widget showCarousel(BuildContext context) {
    return images != null
        ? Container(
            child: Column(
            children: <Widget>[
              CarouselSlider(
                  options: CarouselOptions(
                    height: kIsWeb || Platform.isWindows ? 300 : 200,
                    enableInfiniteScroll: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                            child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: FittedBox(
                              child: Column(
                            children: <Widget>[
                              Image.file(File(i),
                                  height: 200,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width),
                              Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: MaterialButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: BorderSide(color: Colors.grey)),
                                      height: 5,
                                      child:
                                          Icon(Icons.close, color: Colors.black),
                                      onPressed: () {
                                        print("Need deleting :" + i);
                                        this.removeHandler(i);
                                      }))
                            ],
                          )),
                        ));
                      },
                    );
                  }).toList()),
              SizedBox(height: 20)
            ],
          ))
        : Container(width: 0, height: 0);
  }

  @override
  bool updateShouldNotify(Carousel carousel) => carousel.images != images;
}

/*return Container(
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



);*/
