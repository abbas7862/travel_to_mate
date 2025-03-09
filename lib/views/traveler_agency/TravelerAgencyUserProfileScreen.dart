import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/customBtn.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/StateMangment/agencyProfileProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelerAgencyUserProfileScreen extends StatelessWidget {
  const TravelerAgencyUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Travel ', style: TextStyle(color: AppColors.primaryColor)),
            Text('Mate', style: TextStyle(color: AppColors.secondaryColor)),
          ],
        ),
      ),
      body: Consumer<TravelerAgencyProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final agency = provider.agencyData;
          if (agency == null) {
            return Center(child: Text("No data available"));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(agency['logo']),
                ),
                SizedBox(height: 10),
                Text(
                  agency['name'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "⭐ ${provider.averageRating.toStringAsFixed(1)} / 5.0",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(agency['email']),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(agency['address']),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(agency['contact '].toString()),
                ),
                Spacer(),
                CustomBtn(
                    onTap: () async {
                      final navigationProvider =
                          Provider.of<ChnageScreenProvider>(context,
                              listen: false);

                      navigationProvider.resetIndex();
                      await Supabase.instance.client.auth.signOut();
                      Navigator.pop(context);
                    },
                    text: 'Log out')
              ],
            ),
          );
        },
      ),
    );
  }
}
