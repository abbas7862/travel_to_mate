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

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TravelerPostProvider>().fetchPosts());
  }

  Future<void> _deletePost(String postId) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('traveler_posts').delete().eq('id', postId);
    } catch (e) {
      print("Error deleting post: $e");
    }
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
                        onDelete: () => _deletePost(post['id']),
                      );
                    },
                  ),
      ),
    );
  }
}
