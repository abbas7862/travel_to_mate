import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/constants/colors.dart';

class PlanDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> planDetails;

  const PlanDetailsScreen({Key? key, required this.planDetails})
      : super(key: key);

  @override
  _PlanDetailsScreenState createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  final supabase = Supabase.instance.client;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final plan = widget.planDetails;

    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plan Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  plan['image'] ?? "",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey,
                      child: Icon(Icons.broken_image)),
                ),
              ),
              SizedBox(height: 16),

              // Plan Title
              Text(
                plan['title'] ?? "No Title",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Short Description
              Text(plan['short_description'] ?? "",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),

              // Destination & Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Destination: ${plan['destination'] ?? "N/A"}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("Duration: ${plan['duration'] ?? "N/A"}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 16),

              // Facilities
              if (plan['facilities'] != null) ...[
                Text("Facilities:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    (plan['facilities'] as List).length,
                    (index) => Chip(label: Text(plan['facilities'][index])),
                  ),
                ),
                SizedBox(height: 16),
              ],

              // Contact Number
              Text("Contact: ${plan['contact_number'] ?? "N/A"}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Amount
              Text("Price: ${plan['amount'].toString()}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor)),
              SizedBox(height: 16),

              // Username Input
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Contact Input
              TextField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Contact Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text.trim();
                    String contact = _contactController.text.trim();

                    print("Username: $username");
                    print("Contact: $contact");

                    if (username.isEmpty || contact.isEmpty) {
                      print("Error: One or both fields are empty");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill in all fields")),
                      );
                      return;
                    }

                    // Debugging plan details
                    print("Booking for plan: ${plan['title']}");
                    print("Plan ID: ${plan['plan_id']}");
                    print("Destination: ${plan['destination']}");
                    print("Price: ${plan['amount']}");

                    // Creating a booking entry
                    Map<String, dynamic> bookingEntry = {
                      'user_name': username,
                      'user_contact': contact,
                    };

                    print(
                        "Inserting Booking Entry into Supabase: $bookingEntry");

                    try {
                      final response =
                          await supabase.from('bookings').insert(bookingEntry);

                      print("Supabase Response: $response");
                      Navigator.pop(context);
                      _usernameController.clear();
                      _contactController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Booking Successful!")),
                      );
                    } catch (error) {
                      print("Supabase Error: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Booking Failed!")),
                      );
                    }
                  },
                  child: Text("Book Now"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
