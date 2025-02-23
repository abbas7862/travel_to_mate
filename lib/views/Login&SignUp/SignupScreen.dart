import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/customBtn.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/views/Login&SignUp/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
                    CustomTextFeild(
                      hintText: "Enter Your Name",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
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
                      hintText: "Enter Your Email",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    AutoSizeText(
                      "Enter Your Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
                    CustomTextFeild(
                      hintText: "Enter Your Password",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    AutoSizeText(
                      "Confirm Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
                    CustomTextFeild(
                      hintText: "Confirm Password",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.030,
              ),
              CustomBtn(
                text: "Sign Up",
                onTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.020,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    " Have an account?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LogInScreen();
                      }));
                    },
                    child: AutoSizeText(
                      "Log in",
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
            ],
          ),
        ),
      ),
    );
  }
}
