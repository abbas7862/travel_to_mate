import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/StateMangment/ImageProvider.dart';
import 'package:travel_to_mate/StateMangment/PlanProvider.dart';
import 'package:travel_to_mate/constants/colors.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyMainScreenNavigation.dart';

class MainPlanScreen extends StatefulWidget {
  const MainPlanScreen({super.key});

  @override
  State<MainPlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<MainPlanScreen> {
  final supabase = Supabase.instance.client;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final destinationController = TextEditingController();
  final durationController = TextEditingController();
  final facilitiesController = TextEditingController();
  final contactNumberController = TextEditingController();
  final amountController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProv>(context);
    final planProvider = Provider.of<PlanProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Travel ',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            Text(
              'Mate',
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              AutoSizeText(
                'Tour Plan',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              // Title
              AutoSizeText(
                "Title",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: titleController,
                hintText: "Enter Your title",
              ),
              SizedBox(height: 20),
              // Short Description
              AutoSizeText(
                "Short Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: descriptionController,
                hintText: "Enter short description",
              ),
              SizedBox(height: 20),
              // Destination
              AutoSizeText(
                "Destination",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: destinationController,
                hintText: "Enter Your destination",
              ),
              SizedBox(height: 20),
              // Duration
              AutoSizeText(
                "Duration",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: durationController,
                hintText: "Enter trip duration",
              ),
              SizedBox(height: 20),
              // Facilities
              AutoSizeText(
                "Facilities",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: facilitiesController,
                hintText: "Enter facilities (comma-separated)",
              ),
              SizedBox(height: 20),
              // Contact Number
              AutoSizeText(
                "Contact Number",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: contactNumberController,
                hintText: "Enter Contact Number",
              ),
              SizedBox(height: 20),
              // Amount
              AutoSizeText(
                "Amount",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controller: amountController,
                hintText: "Enter Amount",
              ),
              SizedBox(height: 20),
              // Add Image
              AutoSizeText(
                "Add Image",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                      ),
              ),
              SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final description = descriptionController.text;
                  final destination = destinationController.text;
                  final duration = durationController.text;
                  final facilities = facilitiesController.text.split(',');
                  final contactNumber = contactNumberController.text;
                  final amount = double.tryParse(amountController.text) ?? 0.0;

                  final planProvider =
                      Provider.of<PlanProvider>(context, listen: false);
                  await planProvider.submitPlan(
                    context: context,
                    title: title,
                    description: description,
                    destination: destination,
                    duration: duration,
                    facilities: facilities,
                    contactNumber: contactNumber,
                    amount: amount,
                    imageFile: _imageFile,
                  );
                },
                child: Text(
                  'Upload and Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    ),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF088F8F))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
