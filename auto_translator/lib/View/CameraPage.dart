import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {

  @override
  State createState() {
    return new CameraPageState();
  }
}

class CameraPageState extends State<CameraPage> {

  List<CameraDescription> cameras;
  CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: new Container(
                child: new Padding(
                    padding: EdgeInsets.all(1.0),
                    child: CameraPreviewWidget(),
                ),
                decoration: new BoxDecoration(
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.red,
                    width: 3.0
                  )
                ),
              )
          ),
          CameraControlWidget(),
//          new Padding(
//              padding: new EdgeInsets.all(5.0),
//              child: new Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  ThumbnailPreviewWidget()
//                ],
//              ),
//          )
        ],
      ),
      backgroundColor: Colors.orange,
    );
  }

  Widget CameraPreviewWidget() {
    if(cameraController == null || !cameraController.value.isInitialized) {
      return new Center(
        child: new Text(
          "Tap a camera",
          style: new TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w900
          ),
        ),
      );
    }
    else {
      return new Center(
        child: new AspectRatio(
          aspectRatio: cameraController.value.aspectRatio,
          child: new CameraPreview(cameraController),
        ),
      );
    }
  }

  Widget CameraControlWidget() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new IconButton(
            icon: new Icon(Icons.camera_alt),
            color: Colors.white,
            onPressed: TakePicture
        )
      ],
    );
  }

  Widget ThumbnailPreviewWidget() {
    return new Expanded(
        child: new Align(
          alignment: Alignment.centerLeft,
          child: new SizedBox(
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(
                  color: Colors.green
                )
              ),
            ),
            width: 64.0,
            height: 64.0,
          ),
        )
    );
  }

  Future<String> TakePicture() async {
    if(!cameraController.value.isInitialized) {
      print("cam is not initialized while taking picture");
      return null;
    }
    if(cameraController.value.isTakingPicture) {
      print("cam is already taking picture");
      return null;
    }

    Directory exportDir = await getApplicationDocumentsDirectory();
    String exportDirPath = exportDir.path + "/Pictures/flutter_test";
    await new Directory(exportDirPath).create(recursive: true);
    String exportFilePath = exportDirPath + "/" + TimeStamp() + ".jpg";

    try {
      await cameraController.takePicture(exportFilePath);
      print("picture saved at: " + exportFilePath);
      return exportFilePath;
    }
    catch(except) {
      print("something wrong while taking picture: " + except);
      return null;
    }
  }

  String TimeStamp() {
    return new DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  void initState() {
    super.initState();
    InitCamera();
  }

  void InitCamera() async {
    try {
      cameras = await availableCameras();
      print("camera init ok");

//      for(CameraDescription camDescription in cameras) {
//        print("des");
//      }

      ReadyForUseCam(cameras[0]);
    }
    catch(except) {
      print("error while init cam: " + except.code + " des: " + except.description);
    }
  }

  void ReadyForUseCam(CameraDescription cameraDescription) async {
    if(cameraController != null) {
      cameraController.dispose();
    }
    cameraController = new CameraController(
        cameraDescription,
        ResolutionPreset.high
    );
    
    cameraController.addListener(() {
      if(mounted) {
        this.setState(() {

        });
      }
      if(cameraController.value.hasError) {
        print("cam error: " + cameraController.value.errorDescription);
      }
    });

    try {
      await cameraController.initialize();
      print("cam initialize ok");
    }
    catch(except) {
      print("cam initialize failed: " + except);
    }

    if(mounted) {
      this.setState(() {

      });
    }
  }

  @override
  void dispose() {
    if(cameraController != null) {
      cameraController.dispose();
    }
    super.dispose();
  }
}