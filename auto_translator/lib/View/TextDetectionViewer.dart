import 'package:mlkit/mlkit.dart';

import 'package:flutter/material.dart';

class TextDetectionViewer extends Decoration {

  Size originalImageSize;
  List<VisionText> detectionTextList;

  TextDetectionViewer([Size originalImageSize = null, List<VisionText> detectionTextList = null]) {
    this.originalImageSize = originalImageSize;
    this.detectionTextList = detectionTextList;
  }

  void SetOriginalImageSize(Size originalImageSize) {
    this.originalImageSize = originalImageSize;
  }

  void SetDetectionTextList(List<VisionText> detectionTextList) {
    this.detectionTextList = detectionTextList;
  }

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new TextDetectionViewerPainter(originalImageSize, detectionTextList);
  }
}

class TextDetectionViewerPainter extends BoxPainter {

  Size originalImageSize;
  List<VisionText> detectionTextList;

  TextDetectionViewerPainter(this.originalImageSize, this.detectionTextList);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

  }
}