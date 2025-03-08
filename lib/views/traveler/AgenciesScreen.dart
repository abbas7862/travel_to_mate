import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/CustomWidgets/AgencyContainer.dart';
import 'package:travel_to_mate/StateMangment/bookingProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';

class AgenciesScreen extends StatelessWidget {
  const AgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plansProvider = Provider.of<BookingProvider>(context);

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
      body: plansProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : plansProvider.plans.isEmpty
              ? const Center(child: Text("No plans available."))
              : ListView.builder(
                  itemCount: plansProvider.plans.length,
                  itemBuilder: (context, index) {
                    final plan = plansProvider.plans[index];
                    print("Plan $index: $plan"); // Debugging: Print each plan
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AgencyContainer(
                        agencyImg: NetworkImage(plan['image'] ?? ""),
                        img: NetworkImage(plan['image'] ?? ""),
                        agencyName: plan['title'] ?? "Unknown",
                        shortDesc: plan['short_description'] ?? "",
                        planDetails: plan,
                      ),
                    );
                  },
                ),
    );
  }
}
