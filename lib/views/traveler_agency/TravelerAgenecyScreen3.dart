import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyMainScreenNavigation.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyScreen2.dart';

class Traveleragenecyscreen3 extends StatefulWidget {
  const Traveleragenecyscreen3({super.key});

  @override
  State<Traveleragenecyscreen3> createState() => _Traveleragenecyscreen3State();
}

class _Traveleragenecyscreen3State extends State<Traveleragenecyscreen3> {
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
                      "Contact",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
                    CustomTextFeild(
                      hintText: "Enter Your Contact Number",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    AutoSizeText(
                      "Years of Opertation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.010,
                    ),
                    CustomTextFeild(
                      hintText: "Enter Your Years Of Operation",
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
              AutoSizeText(
                "Add Agency Logo",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TravelAgencyMainNavigationScreen();
                  }));
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
            ],
          ),
        ),
      ),
    );
    ;
  }
}
