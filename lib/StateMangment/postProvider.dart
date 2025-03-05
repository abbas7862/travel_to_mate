// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PostProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> posts = [];

//   PostProvider() {
//     fetchPosts();
//   }

//   Future<void> fetchPosts() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('posts')
//         .orderBy('timestamp', descending: true)
//         .get();

//     posts =
//         snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     notifyListeners();
//   }
// }
