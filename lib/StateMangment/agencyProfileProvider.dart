import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TravelerAgencyProfileProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? _agencyData;
  double _averageRating = 0.0;
  bool _isLoading = true;

  Map<String, dynamic>? get agencyData => _agencyData;
  double get averageRating => _averageRating;
  bool get isLoading => _isLoading;

  TravelerAgencyProfileProvider() {
    fetchAgencyData();
  }

  Future<void> fetchAgencyData() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final agencyResponse = await supabase
          .from('agencies')
          .select('*')
          .eq('agency_id', userId)
          .single();

      if (agencyResponse == null) {
        throw Exception("No agency data found");
      }

      final agencyId = agencyResponse['agency_id'];

      final plansResponse = await supabase
          .from('plans')
          .select('plan_id')
          .eq('agency_id', agencyId);

      if (plansResponse.isEmpty) {
        print('No plans found for agency');
        _agencyData = agencyResponse;
        _averageRating = 0.0;
        _isLoading = false;
        notifyListeners();
        return;
      }

      final planIds = plansResponse.map((plan) => plan['plan_id']).toList();

      // Fetch reviews for all plans owned by the agency
      final reviewsResponse = await supabase
          .from('reviews')
          .select('rating')
          .or(planIds.map((id) => "plan_id.eq.$id").join(","));

      if (reviewsResponse.isNotEmpty) {
        double totalRating = reviewsResponse
            .map((review) => review['rating'] as num)
            .reduce((a, b) => a + b)
            .toDouble();

        _averageRating = totalRating / reviewsResponse.length;
      } else {
        _averageRating = 0.0;
        print('No reviews found for agency');
      }

      _agencyData = agencyResponse;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching agency data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}
