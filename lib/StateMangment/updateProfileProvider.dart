import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  String name = "";
  String bio = "";
  String profilePic = "https://via.placeholder.com/150";

  Future<void> fetchUserProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response = await supabase
        .from('users')
        .select('name, bio, profile_pic')
        .eq('id', userId)
        .maybeSingle();

    if (response != null) {
      name = response['name'] ?? "";
      bio = response['bio'] ?? "";
      profilePic = response['profile_pic']?.isNotEmpty == true
          ? response['profile_pic']
          : "https://via.placeholder.com/150"; // Default image
      notifyListeners();
    }
  }

  Future<void> updateProfile(String newName, String newBio) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase
        .from('users')
        .update({'name': newName, 'bio': newBio}).match({'id': userId});
    name = newName;
    bio = newBio;
    notifyListeners();
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final file = File(pickedFile.path);
    final fileName = 'profile_$userId.png';

    final storagePath = 'profile_pics/$fileName';

    // Delete old image (if exists) before uploading a new one
    await supabase.storage.from('post_images').remove([storagePath]);

    // Upload new image to `post_images` bucket
    await supabase.storage.from('post_images').upload(storagePath, file);

    // Get public URL of the uploaded image
    final imageUrl =
        supabase.storage.from('post_images').getPublicUrl(storagePath);

    // Update profile picture URL in the database
    await supabase
        .from('users')
        .update({'profile_pic': imageUrl}).match({'id': userId});

    profilePic = imageUrl;
    notifyListeners();
  }
}
