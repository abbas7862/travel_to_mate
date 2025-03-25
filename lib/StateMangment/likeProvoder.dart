import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LikeProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _likeNotifications = [];

  List<Map<String, dynamic>> get likeNotifications => _likeNotifications;
  Set<String> likedPosts = {};

  bool isLiked(String postId) {
    return likedPosts.contains(postId);
  }

  void clearLikedPosts() {
    likedPosts.clear();
    notifyListeners();
  }

  Future<void> toggleLike(String postId) async {
    try {
      final userId = supabase.auth.currentUser?.id; // Get logged-in user ID
      if (userId == null) {
        print("❌ Error: User is not logged in");
        return;
      }

      if (isLiked(postId)) {
        likedPosts.remove(postId);
        final response = await supabase
            .from('likes')
            .delete()
            .match({'post_id': postId, 'user_id': userId});

        print("🗑 Deleted Like Response: ${response}");
      } else {
        likedPosts.add(postId);
        final response = await supabase.from('likes').insert({
          'post_id': postId,
          'user_id': userId,
        });

        print("❤️ Inserted Like Response: ${response}");
      }

      notifyListeners(); // Refresh UI
    } catch (e) {
      print("❌ Error in toggleLike: $e");
    }
  }

  Future<void> fetchLikeNotifications(String userId) async {
    print("🔍 fetchLikeNotifications called for user ID: $userId");

    try {
      final response = await supabase
          .from('likes')
          .select('''
            like_id, created_at, 
            user_id, post_id,  
            users!likes_user_id_fkey(name, profile_pic), 
            traveler_posts!likes_post_id_fkey(description, user_id)
          ''')
          .eq('traveler_posts.user_id',
              userId) // Ensure likes are on user's posts
          .not('traveler_posts', 'is', null) // Exclude null posts
          .order('created_at', ascending: false);

      print("🛠 Raw Response from Supabase: $response");

      if (response.isEmpty) {
        print("❌ No likes found for user ID: $userId");
      }

      // 🔥 Clear old data before updating
      _likeNotifications.clear();
      _likeNotifications.addAll(response);
      notifyListeners();
    } catch (error) {
      print("⚠️ Error fetching like notifications: $error");
    }
  }
}
