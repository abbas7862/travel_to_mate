import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/constants/colors.dart';
import 'package:travel_to_mate/views/traveler_agency/PlanScreen/MainPlanScreen.dart';

class TravelerAgencyPlanScreen extends StatefulWidget {
  const TravelerAgencyPlanScreen({super.key});

  @override
  State<TravelerAgencyPlanScreen> createState() =>
      _TravelerAgencyPlanScreenState();
}

class _TravelerAgencyPlanScreenState extends State<TravelerAgencyPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Travel ' + 'Mate',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            Text(
              'Mate',
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPlanScreen()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: AutoSizeText(
                    'Create a plan',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
