import 'dart:io';

import 'package:flutter/material.dart';

class Imageselector with ChangeNotifier {
  File? image;
  void selectImage(File? image) {
    this.image = image;
    notifyListeners();
  }
}
