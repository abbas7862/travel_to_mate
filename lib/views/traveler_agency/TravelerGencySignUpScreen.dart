import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/CustomWidgets/customBtn.dart';
import 'package:travel_to_mate/CustomWidgets/customTextFeild.dart';
import 'package:travel_to_mate/StateMangment/agencySignUpProvider.dart';
import 'package:travel_to_mate/views/traveler_agency/TravelerAgencyLoginScreen.dart';

class TravelerAgencySignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController agencyNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController yearsOfOperationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelerAgencyProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.040,
            ),
            Image(image: AssetImage('assets/Images/Logo1.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Join Travel Mate',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF088F8F),
                      fontSize: 20),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.010,
                ),
                AutoSizeText(
                  'Explore Natue',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 27, 153, 255),
                      fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.040,
            ),
            CustomTextFeild(
              controller: emailController,
              hintText: "Email",
              onChanged: provider.updateEmail,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: passwordController,
              hintText: "Password",
              onChanged: provider.updatePassword,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              onChanged: provider.updateConfirmPassword,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: agencyNameController,
              hintText: "Agency Name",
              onChanged: provider.updateAgencyName,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: ownerNameController,
              hintText: "Owner Name",
              onChanged: provider.updateOwnerName,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: addressController,
              hintText: "Address",
              onChanged: provider.updateAddress,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: contactNumberController,
              hintText: "Contact Number",
              onChanged: provider.updateContactNumber,
            ),
            SizedBox(height: 16),
            CustomTextFeild(
              controller: yearsOfOperationController,
              hintText: "Years of Operation",
              onChanged: provider.updateYearsOfOperation,
            ),
            SizedBox(height: 20),
            Text('Add Agency Logo'),
            IconButton(
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: provider.pickLogo,
            ),
            if (provider.logo != null) Image.file(provider.logo!, height: 100),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => provider.submitData(context),
            //   child: provider.isLoading
            //       ? CircularProgressIndicator(color: Colors.white)
            //       : Text('Submit'),
            // ),
            CustomBtn(
              onTap: () => provider.submitData(context),
              text: 'Submit',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  " Have an account?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TravelerAgencyLogInScreen();
                    }));
                  },
                  child: AutoSizeText(
                    "Log in",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
