import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CombinedDataProvider with ChangeNotifier {
  List<Map<String, dynamic>> _combinedData = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get combinedData => _combinedData;
  bool get isLoading => _isLoading;

  final supabase = Supabase.instance.client;

  Future<void> fetchCombinedData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final agencyResponse = await supabase
          .from('agencies')
          .select('agency_id')
          .eq('agency_id', userId)
          .maybeSingle();

      if (agencyResponse == null) {
        print('Agency not found for user: $userId');
        return;
      }

      final String agencyId = agencyResponse['agency_id'];
      print('Fetched Agency ID: $agencyId');

      print('Agency ID: $agencyId');

      final response = await supabase.from('plans').select('''
      plan_id, title, short_description, image, 
      agencies (agency_id, name, logo)
    ''').eq('agency_id', agencyId).order('created_at', ascending: false);

      _combinedData = response;
    } catch (e) {
      print('Error fetching combined data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
