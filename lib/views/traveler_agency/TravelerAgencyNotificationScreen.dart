import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelAgencyNotificationScreen extends StatefulWidget {
  const TravelAgencyNotificationScreen({super.key});

  @override
  State<TravelAgencyNotificationScreen> createState() =>
      _TravelAgencyNotificationScreenState();
}

class _TravelAgencyNotificationScreenState
    extends State<TravelAgencyNotificationScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Travel ', style: TextStyle(color: AppColors.primaryColor)),
            Text('Mate', style: TextStyle(color: AppColors.secondaryColor)),
          ],
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications yet"));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(
                      notification['type'] == 'booking'
                          ? Icons.event_available
                          : Icons.star,
                      color: Colors.blue),
                  title: Text(notification['message']),
                  subtitle: Text(notification['timestamp']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> _fetchNotifications() async* {
    while (true) {
      final bookings = await supabase
          .from('bookings')
          .select('user_name, user_contact, booked_at')
          .order('booked_at', ascending: false);

      final reviews = await supabase
          .from('reviews')
          .select('rating, review_text, created_at')
          .order('created_at', ascending: false);

      final notifications = [
        ...bookings.map((b) => {
              'type': 'booking',
              'message':
                  '${b['user_name']} booked a plan. Contact: ${b['user_contact']}',
              'timestamp': b['booked_at'].toString()
            }),
        ...reviews.map((r) => {
              'type': 'review',
              'message':
                  'New rating: ${r['rating']}/5. Review: ${r['review_text'] ?? "No review"}',
              'timestamp': r['created_at'].toString()
            }),
      ];

      yield notifications;
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
