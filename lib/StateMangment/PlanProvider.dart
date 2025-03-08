import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyMainScreenNavigation.dart';

class PlanProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  Future<String?> getAgencyIdByEmail(String email) async {
    try {
      final response = await supabase
          .from('agencies')
          .select('agency_id')
          .eq('email', email)
          .single();

      return response['agency_id'] as String?;
    } catch (e) {
      print('Error fetching agency_id: $e');
      return null;
    }
  }

  Future<void> submitPlan({
    required BuildContext context,
    required String title,
    required String description,
    required String destination,
    required String duration,
    required List<String> facilities,
    required String contactNumber,
    required double amount,
    required File? imageFile,
  }) async {
    try {
      // Get the logged-in user's email
      final userEmail = supabase.auth.currentUser?.email;
      if (userEmail == null) {
        Fluttertoast.showToast(
          msg: 'User not logged in',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      final agencyId = await getAgencyIdByEmail(userEmail);
      if (agencyId == null) {
        Fluttertoast.showToast(
          msg: 'Agency not found',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      // Upload image to Supabase Storage (if image is selected)
      String? imageUrl;
      if (imageFile != null) {
        final fileExtension = imageFile.path.split('.').last;
        final fileName = '${DateTime.now().toIso8601String()}.$fileExtension';
        final response = await supabase.storage
            .from('post_images') // Updated bucket name
            .upload(fileName, imageFile);

        imageUrl = supabase.storage.from('post_images').getPublicUrl(fileName);
      }

      // Insert plan data into the plans table
      await supabase.from('plans').insert({
        'agency_id': agencyId, // Use the fetched agency_id
        'title': title,
        'short_description': description,
        'image': imageUrl,
        'destination': destination,
        'duration': duration,
        'facilities': facilities,
        'contact_number': contactNumber,
        'amount': amount,
        'created_at': DateTime.now().toIso8601String(),
      });

      // Show success toast
      Fluttertoast.showToast(
        msg: 'Plan submitted successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Navigate to TravelAgencyMainNavigationScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TravelAgencyMainNavigationScreen(),
        ),
      );
    } catch (e) {
      print('Error submitting plan: $e');
      // Show error toast
      Fluttertoast.showToast(
        msg: 'Error submitting plan: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print('Error submitting plan: $e');
    }
  }
}
