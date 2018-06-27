import 'dart:io';

import 'package:mlkit/mlkit.dart';

class TextDetection {
  String imageFilePath;
  FirebaseVisionTextDetector firebaseVisionTextDetector;
  List<VisionText> currentDetectedTextList;

  TextDetection([String imageFilePath = null]) {
    this.imageFilePath = imageFilePath;

    firebaseVisionTextDetector = FirebaseVisionTextDetector.instance;
    currentDetectedTextList = <VisionText>[];
  }

  SetImageFile(String imageFilePath) {
    this.imageFilePath = imageFilePath;
  }

  void AnalyzeTextFromPicture() async {
    try {
      currentDetectedTextList = await firebaseVisionTextDetector.detectFromPath(imageFilePath);
      for(VisionText detectedString in currentDetectedTextList) {
        print("detected text: " + detectedString.text);
      }
    }
    catch(except) {
      print("error while analyze text from pic: " + except);
    }
  }
}