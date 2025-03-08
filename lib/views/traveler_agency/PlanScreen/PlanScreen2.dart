// import 'dart:io';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
// import 'package:travel_to_mate/StateMangment/PlanProvider.dart';
// import 'package:travel_to_mate/constants/colors.dart';

// class PlanScreen2 extends StatefulWidget {
//   final String title;
//   final String description;
//   final File? imageFile;

//   const PlanScreen2(
//       {super.key,
//       required this.title,
//       required this.description,
//       required this.imageFile});

//   @override
//   State<PlanScreen2> createState() => _PlanScreen2State();
// }

// class _PlanScreen2State extends State<PlanScreen2> {
//   final destinationController = TextEditingController();
//   final durationController = TextEditingController();
//   final facilitiesController = TextEditingController();
//   final contactNumberController = TextEditingController();
//   final amountController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text(
//               'Travel ' + 'Mate',
//               style: TextStyle(color: AppColors.primaryColor),
//             ),
//             Text(
//               'Mate',
//               style: TextStyle(color: AppColors.secondaryColor),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AutoSizeText(
//               'Tour Plan',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.040,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AutoSizeText(
//                     "Destination",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   CustomTextFeild(
//                     controller: destinationController,
//                     hintText: "Enter Your destination",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   AutoSizeText(
//                     "Duration",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   CustomTextFeild(
//                     controller: durationController,
//                     hintText: "Enter trip duration",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.020,
//                   ),
//                   AutoSizeText(
//                     "Facilities",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   CustomTextFeild(
//                     controller: facilitiesController,
//                     hintText: "Enter facilities",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   AutoSizeText(
//                     "Contact Number",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   CustomTextFeild(
//                     controller: contactNumberController,
//                     hintText: "Enter Contact Number",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   AutoSizeText(
//                     "Amount",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.010,
//                   ),
//                   CustomTextFeild(
//                     controller: amountController,
//                     hintText: "Enter Amount",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.040,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final destination = destinationController.text;
//                         final duration = durationController.text;
//                         final facilities = facilitiesController.text.split(',');
//                         final contactNumber = contactNumberController.text;
//                         final amount =
//                             double.tryParse(amountController.text) ?? 0.0;

//                         final planProvider =
//                             Provider.of<PlanProvider>(context, listen: false);
//                         await planProvider.submitPlan(
//                           context: context,
//                           title: widget.title,
//                           description: widget.description,
//                           destination: destination,
//                           duration: duration,
//                           facilities: facilities,
//                           contactNumber: contactNumber,
//                           amount: amount,
//                           imageFile: widget.imageFile,
//                         );
//                       },
//                       child: Text(
//                         'Upload and Submit',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ButtonStyle(
//                           padding: MaterialStatePropertyAll(
//                             EdgeInsets.symmetric(horizontal: 70, vertical: 10),
//                           ),
//                           shape:
//                               MaterialStatePropertyAll(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7),
//                           )),
//                           backgroundColor:
//                               MaterialStatePropertyAll(Color(0xFF088F8F))),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
