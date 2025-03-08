import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TravelerPostProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supabase
          .from('traveler_posts')
          .select('post_image,id, description, users (profile_pic, name)')
          .order('created_at', ascending: false);

      _posts = response.map((post) {
        post['id'] = post['id'];
        post['post_image'] = _getPublicUrl(post['post_image']);
        post['users']['profile_pic'] =
            _getPublicUrl(post['users']['profile_pic']);
        return post;
      }).toList();
    } catch (e) {
      print("Error fetching posts: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  String _getPublicUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    }
    if (path.startsWith("http")) return path;

    if (path.startsWith('post_images/')) {
      path = path.replaceFirst('post_images/', '');
    }

    return Supabase.instance.client.storage
        .from('post_images')
        .getPublicUrl(path);
  }
}
