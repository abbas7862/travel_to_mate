import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/travelerScreenContainer.dart';
import 'package:travel_to_mate/StateMangment/postProvider.dart';

import 'package:travel_to_mate/constants/colors.dart';

class TravelerHomeScreen extends StatefulWidget {
  const TravelerHomeScreen({super.key});

  @override
  State<TravelerHomeScreen> createState() => _TravelerHomeScreenState();
}

class _TravelerHomeScreenState extends State<TravelerHomeScreen> {
  final supabase = Supabase.instance.client;

  // Future<List<Map<String, dynamic>>> _fetchPosts() async {
  //   final response = await supabase
  //       .from('traveler_posts')
  //       .select('post_image, description, users (profile_pic, name)')
  //       .order('created_at', ascending: false);

  //   if (response.isEmpty) {
  //     print("No posts found in the database.");
  //     return [];
  //   }

  //   print("Fetched posts: $response");

  //   return response.map((post) {
  //     post['post_image'] = _getPublicUrl(post['post_image']);
  //     post['users']['profile_pic'] =
  //         _getPublicUrl(post['users']['profile_pic']);
  //     return post;
  //   }).toList();
  // }

  // String _getPublicUrl(String? path) {
  //   if (path == null || path.isEmpty) {
  //     print("Path is null or empty, returning default image URL.");
  //     return 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
  //   }sdsd

  //   if (path.startsWith("http")) {
  //     print("Path is already a URL: $path");
  //     return path;
  //   }

  //   if (path.startsWith('post_images/')) {
  //     path = path.replaceFirst('post_images/', '');
  //   }

  //   final publicUrl =
  //       Supabase.instance.client.storage.from('post_images').getPublicUrl(path);

  //   print("Generated public URL for path '$path': $publicUrl");
  //   return publicUrl;
  // }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TravelerPostProvider>().fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<TravelerPostProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Travel ',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text('Mate',
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: RefreshIndicator(
        onRefresh: () => postProvider.fetchPosts(),
        child: postProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : postProvider.posts.isEmpty
                ? const Center(
                    child: Text(
                      "No posts available",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: postProvider.posts.length,
                    itemBuilder: (context, index) {
                      final post = postProvider.posts[index];
                      print("TravelerHomeScreen - Post Data: $post");
                      print("Post ID: ${post['id']}");
                      return TravelerScreenContainer(
                        postId: post['id'],
                        image: NetworkImage(post['users']['profile_pic'] ?? ""),
                        image2: NetworkImage(post['post_image'] ?? ""),
                        name: post['users']['name'] ?? "Anonymous Traveler",
                        description: post['description'] ?? "",
                      );
                    },
                  ),
      ),
    );
  }
}
