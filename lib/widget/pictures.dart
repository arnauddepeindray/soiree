import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soiree/style/colors.dart';


class TakePicture extends StatefulWidget {


  const TakePicture({super.key, required this.camera, this.addHandler}) ;
  final CameraDescription camera;
  final addHandler;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TakePictureState();
  }
  
}

class TakePictureState extends State<TakePicture> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller!);
              } else {
                // Otherwise, display a loading indicator.
                return Container(width: 0, height: 0);
              }
            },
          ),
          FloatingActionButton(
            backgroundColor: primaryColor,
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _controller?.takePicture();
                widget.addHandler(image);

              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ],
      );

  }
  
}