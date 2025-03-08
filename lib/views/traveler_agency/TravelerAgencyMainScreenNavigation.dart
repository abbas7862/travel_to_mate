import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyNotificationScreen.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyHomeScreen.dart';
import 'package:travel_to_mate/views/traveler_agency/PlanScreen/TravelerAgencyPlanScreen.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyUserProfileScreen.dart';

class TravelAgencyMainNavigationScreen extends StatefulWidget {
  const TravelAgencyMainNavigationScreen({super.key});

  @override
  State<TravelAgencyMainNavigationScreen> createState() =>
      _TravelAgencyMainNavigationScreenState();
}

class _TravelAgencyMainNavigationScreenState
    extends State<TravelAgencyMainNavigationScreen> {
  final List<Widget> _screen = [
    TravelerAgencyHomeScreen(),
    TravelerAgencyPlanScreen(),
    TravelAgencyNotificationScreen(),
    TravelerAgencyUserProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<ChnageScreenProvider>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: IndexedStack(
          index: navigationProvider.getSelectedIndex,
          children: _screen,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.getSelectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (index) => navigationProvider.updateIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Plan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
