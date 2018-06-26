class PictureData {
  String pictureSavedPath;

//  PictureData(this.pictureSavedPath);
  PictureData([String pictureSavedPath = null]) {
    this.pictureSavedPath = pictureSavedPath;
  }

  void SetPictureSavedPath(String pictureSavedPath) {
    this.pictureSavedPath = pictureSavedPath;
  }

  String GetPictureSavedPath() {
    return pictureSavedPath;
  }
}