import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _plans = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get plans => _plans;
  bool get isLoading => _isLoading;

  BookingProvider() {
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      _isLoading = true;
      notifyListeners();
      print("Fetching plans from Supabase...");

      // Fetch plans from the 'plans' table
      final response = await supabase.from('plans').select();

      // Debugging: Print the response
      print("Supabase Response: $response");

      if (response != null && response.isNotEmpty) {
        _plans = List<Map<String, dynamic>>.from(response);
        print("Plans fetched successfully: ${_plans.length} plans found.");
      } else {
        print("No plans found in the 'plans' table.");
      }
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
      print("Fetch complete. isLoading: $_isLoading");
    }
  }
}
