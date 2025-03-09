import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _plans = [];
  List<Map<String, dynamic>> _filteredPlans = [];
  bool _isLoading = true;
  String _searchQuery = "";

  List<Map<String, dynamic>> get plans =>
      _searchQuery.isEmpty ? _plans : _filteredPlans;
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
        _filteredPlans = _plans; // Initialize filtered plans with all plans
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

  void searchPlans(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredPlans = _plans; // If query is empty, show all plans
    } else {
      _filteredPlans = _plans
          .where((plan) =>
              plan['title']?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList(); // Filter plans by title
    }
    notifyListeners();
  }
}
