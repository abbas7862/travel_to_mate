import 'package:flutter/material.dart';

class LikeProvider with ChangeNotifier {
  final Map<String, bool> _likedPosts = {};

  bool isLiked(String postId) => _likedPosts[postId] ?? false;

  void toggleLike(String postId) {
    _likedPosts[postId] = !isLiked(postId);
    notifyListeners();
  }
}
