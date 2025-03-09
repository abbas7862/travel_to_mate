import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/StateMangment/likeProvoder.dart';

class LikesNotificationScreen extends StatefulWidget {
  const LikesNotificationScreen({super.key});

  @override
  _LikesNotificationScreenState createState() =>
      _LikesNotificationScreenState();
}

class _LikesNotificationScreenState extends State<LikesNotificationScreen> {
  final supabase = Supabase.instance.client;
  String? getCurrentUserId() {
    final currentUser = supabase.auth.currentUser;
    return currentUser?.id;
  }

  @override
  void initState() {
    super.initState();
    print("🎬 initState called");
    final userId = getCurrentUserId();
    if (userId != null) {
      Provider.of<LikeProvider>(context, listen: false)
          .fetchLikeNotifications(userId);
    } else {
      print("❌ No user ID found");
    }
  }

  Future<void> _refreshNotifications() async {
    print("🔄 Refreshing Notifications...");
    await Provider.of<LikeProvider>(context, listen: false)
        .fetchLikeNotifications(getCurrentUserId()!);
  }

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<LikeProvider>(context).likeNotifications;
    return Scaffold(
      appBar: AppBar(title: const Text("Like Notifications")),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            print("🔔 Notification: $notification");

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  notification['users']['profile_pic'] ??
                      'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                ),
              ),
              title: Text("${notification['users']['name']} liked your post"),
              trailing: const Icon(Icons.favorite, color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}
