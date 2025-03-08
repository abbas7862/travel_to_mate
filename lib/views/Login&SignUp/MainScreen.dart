import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/MainScreenPolyGon.dart';
import 'package:travel_to_mate/views/Login&SignUp/LoginScreen.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyLoginScreen.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerGencySignUpScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              color: Color(0xFF088F8F),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Welcome',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        'to Travel Mate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          AutoSizeText('Choose Your Type', style: TextStyle(fontSize: 20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.040,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LogInScreen();
              }));
            },
            child: Text(
              'Traveler',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                ),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )),
                backgroundColor: MaterialStatePropertyAll(Color(0xFF088F8F))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.040,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TravelerAgencyLogInScreen();
              }));
            },
            child: Text(
              'Traveler Agency',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 47, vertical: 10),
                ),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )),
                backgroundColor: MaterialStatePropertyAll(Color(0xFF088F8F))),
          ),
        ],
      ),
    );
  }
}
