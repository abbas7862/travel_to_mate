import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyMainScreenNavigation.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerGencySignUpScreen.dart';

class TravelerAgencyLogInScreen extends StatefulWidget {
  const TravelerAgencyLogInScreen({super.key});

  @override
  State<TravelerAgencyLogInScreen> createState() =>
      _TravelerAgencySignUpScreenState();
}

class _TravelerAgencySignUpScreenState
    extends State<TravelerAgencyLogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> logIn(String email, String password) async {
    try {
      final AuthResponse authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final String userId = authResponse.user!.id;
      final agencyResponse = await supabase
          .from('agencies')
          .select()
          .eq('agency_id', userId)
          .single();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TravelAgencyMainNavigationScreen(),
        ),
      );

      Fluttertoast.showToast(
        msg: 'Login Successful',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');

      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {}
  }

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
                        hintText: "Enter Your email",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
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
                  height: MediaQuery.of(context).size.height * 0.040,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text;
                    final password = passwordController.text;

                    await logIn(email, password);
                  },
                  child: Text(
                    'Next',
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
                          return TravelerAgencySignUpScreen();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: AutoSizeText(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
