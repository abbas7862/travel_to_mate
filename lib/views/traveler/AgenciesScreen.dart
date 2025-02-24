import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/AgencyContainer.dart';
import 'package:travel_to_mate/constants/colors.dart';

class AgenciesScreen extends StatefulWidget {
  const AgenciesScreen({super.key});

  @override
  State<AgenciesScreen> createState() => _AgenciesScreenState();
}

class _AgenciesScreenState extends State<AgenciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            AutoSizeText('Travel ',
                style: TextStyle(color: AppColors.primaryColor)),
            AutoSizeText('Mate',
                style: TextStyle(color: AppColors.secondaryColor)),
          ]),
          actions: [Icon(Icons.notifications)],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AgencyContainer(
              agencyImg: AssetImage('assets/Images/agencyImg.png'),
              img: AssetImage('assets/Images/tavelling_pic_2.png'),
              agencyName: 'PTT Travelers',
              shortDesc: "this is short description of the lake ",
            ),
          ),
          itemCount: 10,
        ));
  }
}
