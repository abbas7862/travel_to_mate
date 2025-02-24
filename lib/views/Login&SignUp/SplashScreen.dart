import 'dart:async';

import 'package:flutter/material.dart';

import 'package:travel_to_mate/views/Login&SignUp/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF088F8F),
      child: Center(
        child: Image.asset('assets/Images/splasshScreenLogo.png'),
      ),
    );
  }
}
