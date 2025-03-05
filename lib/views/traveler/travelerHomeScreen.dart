import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/travelerScreenContainer.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelerHomeScreen extends StatefulWidget {
  const TravelerHomeScreen({super.key});

  @override
  State<TravelerHomeScreen> createState() => _TravelerHomeScreenState();
}

class _TravelerHomeScreenState extends State<TravelerHomeScreen> {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> _fetchPosts() async {
    final response = await supabase
        .from('traveler_posts')
        .select('post_image, description, users (profile_pic, name)')
        .order('created_at', ascending: false);

    if (response.isEmpty) {
      print("No posts found in the database.");
      return [];
    }

    print("Fetched posts: $response");

    return response.map((post) {
      post['post_image'] = _getPublicUrl(post['post_image']);
      post['users']['profile_pic'] =
          _getPublicUrl(post['users']['profile_pic']);
      return post;
    }).toList();
  }

  String _getPublicUrl(String? path) {
    if (path == null || path.isEmpty) {
      print("Path is null or empty, returning default image URL.");
      return 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    }

    if (path.startsWith("http")) {
      print("Path is already a URL: $path");
      return path;
    }

    if (path.startsWith('post_images/')) {
      path = path.replaceFirst('post_images/', '');
    }

    final publicUrl =
        Supabase.instance.client.storage.from('post_images').getPublicUrl(path);

    print("Generated public URL for path '$path': $publicUrl");
    return publicUrl;
  }

  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts().then((data) {
      setState(() {
        _posts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Travel ', style: TextStyle(color: AppColors.primaryColor)),
            Text('Mate', style: TextStyle(color: AppColors.secondaryColor)),
          ],
        ),
        actions: [Icon(Icons.notifications)],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print("Error loading posts: ${snapshot.error}");
            return Center(child: Text("Error loading posts"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No posts available"));
          }
          final posts = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final postImage = post['post_image'] ?? "";
              final description = post['description'] ?? "";
              final user = post['users'];
              final userName = user?['name'] ?? "Anonymous Traveler";
              final profileImage = user?['profile_pic'] ??
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png';

              print(
                  "Post $index: Image URL: $postImage, Description: $description, User: $userName"); // Log post details

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TravelerScreenContainer(
                  image: NetworkImage(profileImage),
                  image2: NetworkImage(postImage),
                  name: userName,
                  description: description,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
