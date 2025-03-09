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

    Future<void> _refreshPlans() async {
      await plansProvider.fetchPlans(); // Call the function to fetch data again
    }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by agency name...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                plansProvider.searchPlans(query); // Update search query
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshPlans, // Triggered when user pulls down
              child: plansProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : plansProvider.plans.isEmpty
                      ? const Center(child: Text("No plans available."))
                      : ListView.builder(
                          itemCount: plansProvider.plans.length,
                          itemBuilder: (context, index) {
                            final plan = plansProvider.plans[index];
                            print("Plan $index: $plan");
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
            ),
          ),
        ],
      ),
    );
  }
}
