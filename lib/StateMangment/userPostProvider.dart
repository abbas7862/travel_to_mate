import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserPostProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _userPosts = [];
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;

  List<Map<String, dynamic>> get userPosts => _userPosts;

  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  Future<void> fetchUserData(String userId) async {
    try {
      final response = await supabase
          .from('users')
          .select('name, profile_pic , bio')
          .eq('id', userId)
          .single();
      _userProfile = {
        'name': response['name'],
        'profile_pic': response['profile_pic'] ??
            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
        'bio': response['bio'],
      };
      notifyListeners();
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  Future<void> fetchUserPosts(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supabase
          .from('traveler_posts')
          .select('post_image, description')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      _userPosts = response.map((post) {
        post['post_image'] = _getPublicUrl(post['post_image']);
        return post;
      }).toList();
    } catch (e) {
      print("Error fetching user posts: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  String _getPublicUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    }
    if (path.startsWith("http")) return path;

    return Supabase.instance.client.storage
        .from('post_images')
        .getPublicUrl(path);
  }
}
