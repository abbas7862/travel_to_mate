import 'package:flutter/material.dart';

import 'package:travel_to_mate/CustomWidgets/travelerScreenContainer.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelerHomeScreen extends StatefulWidget {
  const TravelerHomeScreen({super.key});

  @override
  State<TravelerHomeScreen> createState() => _TravelerHomeScreenState();
}

class _TravelerHomeScreenState extends State<TravelerHomeScreen> {
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TravelerScreenContainer(
                  image: AssetImage('assets/Images/Ellipse 3.png'),
                  image2: AssetImage('assets/Images/travelling_pic.png'),
                  name: 'Abbas Khan',
                ),
              ),
          itemCount: 5),
    );
  }
}
