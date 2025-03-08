import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/StateMangment/updateProfileProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';
import 'package:travel_to_mate/views/traveler/MainTravelerScreen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ProfileProvider>(context, listen: false)
        .fetchUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

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
      body: RefreshIndicator(
        onRefresh: profileProvider.fetchUserProfile,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => profileProvider.pickAndUploadImage(),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(profileProvider.profilePic),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Profile", style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                _buildInputField("Name", nameController, profileProvider.name),
                SizedBox(height: 20),
                _buildInputField("Bio", bioController, profileProvider.bio),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    profileProvider.updateProfile(
                      nameController.text,
                      bioController.text,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainNavigationScreen()));
                  },
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF088F8F)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, String initialValue) {
    controller.text = initialValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        CustomTextFeild(hintText: "Enter Your $label", controller: controller),
      ],
    );
  }
}
