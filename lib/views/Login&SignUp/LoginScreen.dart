import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/Supabase/authentication.dart';

import 'package:travel_to_mate/views/Login&SignUp/SignupScreen.dart';
import 'package:travel_to_mate/views/traveler/MainTravelerScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.040,
                ),
                Image(image: AssetImage('assets/Images/Logo1.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Join Travel Mate',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF088F8F),
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.010,
                    ),
                    AutoSizeText(
                      'Explore Natue',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 27, 153, 255),
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.040,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      CustomTextFeild(
                        controller: emailController,
                        hintText: "Enter Your Email",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.050,
                      ),
                      AutoSizeText(
                        "Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      CustomTextFeild(
                        controller: passwordController,
                        hintText: "Enter Your Password",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.050,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "⚠️ Please enter email and password",
                          gravity: ToastGravity.TOP);
                      return;
                    }

                    try {
                      bool isLoggedIn =
                          await Authentication().logIn(email, password);

                      if (isLoggedIn) {
                        emailController.clear();
                        passwordController.clear();
                        Fluttertoast.showToast(msg: "Login successful!");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainNavigationScreen()),
                        );
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: e.toString(), gravity: ToastGravity.TOP);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                      ),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      )),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF088F8F))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpScreen();
                        }));
                      },
                      child: AutoSizeText(
                        " Sign Up",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                AutoSizeText(
                  'Privacy policy & Terms',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 10),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
