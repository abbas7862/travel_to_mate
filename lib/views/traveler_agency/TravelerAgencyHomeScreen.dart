import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/CustomWidgets/travelerAgencyHomeScreenContainer.dart';

import 'package:travel_to_mate/StateMangment/agencyPostProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';

class TravelerAgencyHomeScreen extends StatefulWidget {
  const TravelerAgencyHomeScreen({super.key});

  @override
  State<TravelerAgencyHomeScreen> createState() =>
      _TravelerAgencyHomeScreenState();
}

class _TravelerAgencyHomeScreenState extends State<TravelerAgencyHomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final combinedDataProvider =
          Provider.of<CombinedDataProvider>(context, listen: false);
      combinedDataProvider.fetchCombinedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final combinedDataProvider = Provider.of<CombinedDataProvider>(context);
    final combinedData = combinedDataProvider.combinedData;

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
      body: RefreshIndicator(
        onRefresh: () async {
          await combinedDataProvider.fetchCombinedData();
        },
        child: combinedDataProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : combinedData.isEmpty
                ? Center(child: Text('No posts available'))
                : ListView.builder(
                    itemCount: combinedData.length,
                    itemBuilder: (context, index) {
                      final plan = combinedData[index];
                      final agency = plan['agencies'] as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: TravelerAgencyHomeScreenContainer(
                          imgLogo: NetworkImage(agency['logo']),
                          img: NetworkImage(plan['image']),
                          name: agency['name'],
                          description: plan['short_description'],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
