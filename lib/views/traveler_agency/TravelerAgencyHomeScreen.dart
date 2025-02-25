import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/travelerAgencyHomeScreenContainer.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelerAgencyHomeScreen extends StatefulWidget {
  const TravelerAgencyHomeScreen({super.key});

  @override
  State<TravelerAgencyHomeScreen> createState() =>
      _TravelerAgencyHomeScreenState();
}

class _TravelerAgencyHomeScreenState extends State<TravelerAgencyHomeScreen> {
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
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: TravelerAgencyHomeScreenContainer(
            imgLogo: AssetImage('assets/Images/agencyImg.png'),
            img: AssetImage('assets/Images/tavelling_pic_2.png'),
            name: "PTT Travelers",
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
