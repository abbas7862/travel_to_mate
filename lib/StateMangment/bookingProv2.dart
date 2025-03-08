import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingProv extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  Future<void> bookPlan(
      String planId, String userName, String userContact) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('bookings').insert({
      'user_id': user.id,
      'plan_id': planId,
      'user_name': userName,
      'user_contact': userContact,
    });
  }
}
