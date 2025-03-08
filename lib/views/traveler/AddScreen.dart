import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/StateMangment/imageSelector.dart';
import 'package:travel_to_mate/constants/colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController discriptionController = TextEditingController();
  File? _seletectImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<Imageselector>(context, listen: false)
          .selectImage(File(pickedFile.path));
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User  not logged in");
    }

    try {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

      await supabase.storage.from('post_images').upload(fileName, imageFile);

      final imageUrl =
          supabase.storage.from('post_images').getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      throw Exception("Image upload failed: ${e.toString()}");
    }
  }

  Future<void> _uploadPost() async {
    final navigator = Provider.of<ChnageScreenProvider>(context, listen: false);
    print('Post was tapped');

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null ||
        _seletectImage == null ||
        discriptionController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please select an image and enter a description.");
      return;
    }

    try {
      final imageUrl = await _uploadImage(_seletectImage!);
      await supabase.from('traveler_posts').insert({
        'user_id': user.id,
        'post_image': imageUrl,
        'description': discriptionController.text.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });
      Fluttertoast.showToast(msg: "Post uploaded successfully!");

      navigator.updateIndex(0);
      print("File path after upload: $imageUrl");
      discriptionController.clear();
      Provider.of<Imageselector>(context, listen: false).selectImage(null);
    } catch (e) {
      print("Error uploading post: $e");
      Fluttertoast.showToast(msg: "Unable to Upload post: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    _seletectImage = Provider.of<Imageselector>(context).image;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Travel ',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text('Mate',
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create a Post",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 10),
            TextField(
              controller: discriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Enter Description",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 15),
            _seletectImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_seletectImage!,
                        height: 200, width: double.infinity, fit: BoxFit.cover),
                  )
                : Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[200],
                    ),
                    child: const Center(
                      child: Text("No image selected",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text("Pick Image",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Post was tapped');
                  _uploadPost();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Post",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
