import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/constants/colors.dart';
import 'package:travel_to_mate/views/traveler/UpdateProfileScreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Travel ',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            Text(
              'Mate',
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ],
        ),
        actions: [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return MainTravelerScreen();
                      // }));
                    },
                    child: AutoSizeText(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 7),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        ),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF088F8F))),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UpdateProfileScreen();
                      }));
                    },
                    child: Icon(Icons.menu))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            width: MediaQuery.of(context).size.width * 0.3, // Increased width
            height: MediaQuery.of(context).size.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image(
                image: AssetImage('assets/Images/travelling_pic.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          AutoSizeText(
            'Abbas Khan',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          AutoSizeText(
            'Dummy Text is added here',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 15, // Add itemCount
              itemBuilder: (context, index) => Container(
                child: Image.asset('assets/Images/profileScreenImg.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
