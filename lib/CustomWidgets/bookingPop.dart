import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/StateMangment/bookingProv2.dart';
import 'package:travel_to_mate/StateMangment/bookingProvider.dart';

class BookingPopup extends StatefulWidget {
  final Map<String, dynamic> planDetails;

  const BookingPopup({required this.planDetails, super.key});

  @override
  _BookingPopupState createState() => _BookingPopupState();
}

class _BookingPopupState extends State<BookingPopup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProv>(context, listen: false);

    return AlertDialog(
      title: Text("Confirm Booking for ${widget.planDetails['title']}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Your Name")),
          TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Your Contact")),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            await bookingProvider.bookPlan(
              widget.planDetails['plan_id'],
              nameController.text,
              contactController.text,
            );
            Navigator.pop(context);
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
