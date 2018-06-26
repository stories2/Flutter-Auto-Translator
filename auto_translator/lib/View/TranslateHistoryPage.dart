import 'dart:io';

import 'package:flutter/material.dart';

class TranslateHistoryPage extends StatefulWidget {

  @override
  State createState() {
    return new TranslateHistoryPageState();
  }
}

class TranslateHistoryPageState extends State<TranslateHistoryPage> {

  String translatedResult = "", imageFilePath;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            TakenPicturePreview(),
            TranslatedResultView()
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
              child: imageFilePath == null ?
              NotReadyForShowPicture() : ShowPicture(),
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

  Widget ShowPicture() {
    return new Image.file(new File(imageFilePath));
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
    this.setState((){
      imageFilePath = null;
    });
  }
}