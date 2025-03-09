import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/ProfileScreenView.dart';
import 'package:travel_to_mate/CustomWidgets/fullscreenViewer.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/StateMangment/userPostProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';
import 'package:travel_to_mate/views/Login&SignUp/LoginScreen.dart';
import 'package:travel_to_mate/views/traveler/UpdateProfileScreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      userId = currentUser.id;
      Future.microtask(() {
        final provider = context.read<UserPostProvider>();
        provider.fetchUserData(userId!);
        provider.fetchUserPosts(userId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<UserPostProvider>();

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
      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await Supabase.instance.client.auth.signOut();
                          final navigationProvider =
                              Provider.of<ChnageScreenProvider>(context,
                                  listen: false);

                          navigationProvider.resetIndex();
                          Navigator.pop(context);
                        },
                        child: AutoSizeText('Logout',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF088F8F),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UpdateProfileScreen();
                          }));
                        },
                        child: Icon(Icons.menu),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: postProvider.userProfile != null
                      ? NetworkImage(postProvider.userProfile!['profile_pic'] ??
                          'https://cdn-icons-png.flaticon.com/512/149/149071.png')
                      : AssetImage('assets/Images/travelling_pic.png')
                          as ImageProvider,
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  postProvider.userProfile?['name'] ?? 'Random User',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                AutoSizeText(
                  postProvider.userProfile?['bio'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => postProvider.fetchUserPosts(userId!),
                    child: postProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : postProvider.userPosts.isEmpty
                            ? Center(child: Text("No posts available"))
                            : GridView.builder(
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                itemCount: postProvider.userPosts.length,
                                itemBuilder: (context, index) {
                                  final post = postProvider.userPosts[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileFullScreen(
                                                  imageUrl: post['post_image']),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(post['post_image'],
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
    );
  }
}
