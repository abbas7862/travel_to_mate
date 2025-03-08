import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyMainScreenNavigation.dart';

class TravelerAgencyProvider with ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  String email = '';
  String password = '';
  String confirmPassword = '';
  String agencyName = '';
  String ownerName = '';
  String address = '';
  String contactNumber = '';
  String yearsOfOperation = '';
  File? logo;
  bool isLoading = false;

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void updateAgencyName(String value) {
    agencyName = value;
    notifyListeners();
  }

  void updateOwnerName(String value) {
    ownerName = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  void updateContactNumber(String value) {
    contactNumber = value;
    notifyListeners();
  }

  void updateYearsOfOperation(String value) {
    yearsOfOperation = value;
    notifyListeners();
  }

  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      logo = File(image.path);
      notifyListeners();
    }
  }

  bool isFormValid() {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword &&
        agencyName.isNotEmpty &&
        ownerName.isNotEmpty &&
        address.isNotEmpty &&
        contactNumber.isNotEmpty &&
        yearsOfOperation.isNotEmpty &&
        logo != null;
  }

  Future<void> submitData(BuildContext context) async {
    // Validate form fields
    if (!isFormValid()) {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter your email.", backgroundColor: Colors.red);
      } else if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter your password.", backgroundColor: Colors.red);
      } else if (confirmPassword.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please confirm your password.", backgroundColor: Colors.red);
      } else if (password != confirmPassword) {
        Fluttertoast.showToast(
            msg: "Passwords do not match.", backgroundColor: Colors.red);
      } else if (agencyName.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter your agency name.", backgroundColor: Colors.red);
      } else if (ownerName.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter the owner's name.", backgroundColor: Colors.red);
      } else if (address.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter your address.", backgroundColor: Colors.red);
      } else if (contactNumber.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter your contact number.",
            backgroundColor: Colors.red);
      } else if (yearsOfOperation.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter years of operation.",
            backgroundColor: Colors.red);
      } else if (logo == null) {
        Fluttertoast.showToast(
            msg: "Please upload an agency logo.", backgroundColor: Colors.red);
      }
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      // Step 1: Sign up the user in Supabase Auth
      final AuthResponse authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final String userId = authResponse.user!.id;

      String imageUrl = '';
      if (logo != null) {
        final String imagePath =
            'post_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        await supabase.storage.from('post_images').upload(imagePath, logo!);
        imageUrl = supabase.storage.from('post_images').getPublicUrl(imagePath);
      }

      await supabase.from('agencies').insert({
        'agency_id': userId,
        'name': agencyName,
        'address': address,
        'contact': contactNumber,
        'years_of_operation': int.parse(yearsOfOperation),
        'logo': imageUrl,
        'email': email,
        'password': password,
      });

      Fluttertoast.showToast(
          msg: "Registration Successful!", backgroundColor: Colors.green);

      resetForm();

      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TravelAgencyMainNavigationScreen(),
        ),
      );
    } catch (e) {
      if (e.toString().contains("duplicate key value")) {
        Fluttertoast.showToast(
            msg: "Email already exists. Please use a different email.");
      } else if (e.toString().contains("invalid input syntax")) {
        Fluttertoast.showToast(msg: "Invalid input. Please check your data.");
      } else {
        Fluttertoast.showToast(msg: "Registration failed: ${e.toString()}");
      }
      print("Database Insert Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetForm() {
    email = '';
    password = '';
    confirmPassword = '';
    agencyName = '';
    ownerName = '';
    address = '';
    contactNumber = '';
    yearsOfOperation = '';
    logo = null;
    notifyListeners();
  }
}
