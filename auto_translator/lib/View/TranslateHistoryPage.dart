import 'dart:io';

import 'package:flutter/material.dart';
import '../Model/PictureData.dart';
import '../Core/TextDetection.dart';
import './TextDetectionViewer.dart';

class TranslateHistoryPage extends StatefulWidget {

  PictureData pictureData;

  TranslateHistoryPage(this.pictureData);

  @override
  State createState() {
    return new TranslateHistoryPageState(pictureData);
  }
}

class TranslateHistoryPageState extends State<TranslateHistoryPage> {

  String translatedResult = "";
  PictureData pictureData;
  TextDetection textDetection;

  TranslateHistoryPageState(this.pictureData);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            TakenPicturePreview(),
//            TranslatedResultView()
          ],
        ),
      ),
      backgroundColor: Colors.purpleAccent,
    );
  }

  Widget TranslatedResultView() {
    return new SizedBox(
      height: 64.0,
      child: new Container(
//        color: Colors.blue,
        child: new Padding(
          padding: EdgeInsets.all(0.0),
          child: new Text(
            translatedResult,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w900
            ),
          ),
        ),
      )
    );
  }

  Widget TakenPicturePreview() {
    return new Expanded(
        child: new Padding(
          padding: EdgeInsets.only(
            bottom: 0.0
          ),
          child: new Container(
            child: new Center(
              child: pictureData.GetPictureSavedPath() == null ?
              NotReadyForShowPicture() : ShowPicture(pictureData.GetPictureSavedPath()),
            ),
            decoration: new BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.orange,
                  width: 3.0
                )
            ),
          ),
        )
    );
  }

  Widget ShowPicture(String currentTakenPictureSavedPath) {
    textDetection.SetImageFile(currentTakenPictureSavedPath);
    textDetection.AnalyzeTextFromPicture();
    return new Container(
      foregroundDecoration: null,
      child: new Image.file(new File(currentTakenPictureSavedPath)),
    );
  }

  Widget NotReadyForShowPicture() {
    return new Text(
      "Picture will display here",
      style: new TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("history view init");
    textDetection = new TextDetection();
//    this.setState((){
//      try {
//        imageFilePath = pictureData.GetPictureSavedPath();
//        print("history pic path: " + imageFilePath);
//      }
//      catch (except) {
//        print("cannot get pic path: " + except);
//      }
//    });
  }
}