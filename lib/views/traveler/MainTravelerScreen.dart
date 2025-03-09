import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/views/traveler/AddScreen.dart';
import 'package:travel_to_mate/views/traveler/AgenciesScreen.dart';
import 'package:travel_to_mate/views/traveler/UserProfileScreen.dart';
import 'package:travel_to_mate/views/traveler/travelerHomeScreen.dart';
import 'package:travel_to_mate/views/traveler/travelerNotificationScreen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final supabase = Supabase.instance.client;
  String? userId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<ChnageScreenProvider>(context);

    final List<Widget> screens = [
      TravelerHomeScreen(),
      AgenciesScreen(),
      AddScreen(),
      LikesNotificationScreen(),
      UserProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IndexedStack(
          index: navigationProvider.getSelectedIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationProvider.getSelectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: (index) => navigationProvider.updateIndex(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'Agencies'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
