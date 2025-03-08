import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/bookingPop.dart';

class AgencyContainer extends StatefulWidget {
  final ImageProvider agencyImg;
  final ImageProvider img;
  final String agencyName;
  final String shortDesc;
  final Map<String, dynamic> planDetails;

  const AgencyContainer({
    required this.agencyImg,
    required this.img,
    required this.agencyName,
    required this.shortDesc,
    required this.planDetails,
    super.key,
  });

  @override
  State<AgencyContainer> createState() => _AgencyContainerState();
}

class _AgencyContainerState extends State<AgencyContainer> {
  double _currentRating = 0; // Stores selected rating

  // Function to submit rating to Supabase
  Future<void> _submitRating(double rating) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You need to log in to rate.")),
      );
      return;
    }

    try {
      await supabase.from('reviews').insert({
        'user_id': userId,
        'plan_id': widget.planDetails['plan_id'],
        'rating': rating.toInt(),
        'review_text': "User rated ${rating.toInt()} stars",
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "You rated ${widget.agencyName} ${rating.toInt()} stars!")),
      );
    } catch (e) {
      print("Error submitting rating: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting rating: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Agency Info**
          ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.agencyImg,
              radius: 25,
            ),
            title: AutoSizeText(widget.agencyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: AutoSizeText(widget.shortDesc,
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ),

          // **Image Section**
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: widget.img,
              width: double.infinity,
              height: 180, // Fixed height for uniform cards
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          // **Rating Bar**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Text("Rate: ",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                RatingBar.builder(
                  initialRating: _currentRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 25,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() => _currentRating = rating);
                    _submitRating(rating);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // **Book Now Button**
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      BookingPopup(planDetails: widget.planDetails),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF088F8F),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
