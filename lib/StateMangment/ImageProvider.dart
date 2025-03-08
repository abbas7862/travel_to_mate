import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageProv with ChangeNotifier {
  File? _imageFile;

  File? get imageFile => _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners(); // Notify listeners when the image is updated
    }
  }

  void clearImage() {
    _imageFile = null;
    notifyListeners(); // Notify listeners when the image is cleared
  }
}
