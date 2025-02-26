import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signUp function
  Future<void> signUp(String name, String email, String password) async {
    try {
      var methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Email already registered, please log in');
        throw 'Email already exists';
      }

      // Register user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user == null) {
        Fluttertoast.showToast(msg: "User creation failed!");
        throw "User is null after registration";
      }

      print("User UID: ${user.uid}");

      // Wait before Firestore write (in case of delays)
      await Future.delayed(Duration(seconds: 1));

      // Write user data to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "createdAt": DateTime.now().toIso8601String(),
      });

      Fluttertoast.showToast(msg: "SignUp Successful");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      Fluttertoast.showToast(msg: e.message ?? "Authentication Error");
      throw e.message ?? "Authentication failed";
    } catch (e) {
      print("Unexpected Error: $e");
      Fluttertoast.showToast(msg: "Error: $e");
      throw "Unexpected error occurred";
    }
  }

  //login Function

  Future<void> loginUser(String email, String password) async {
    try {
      // Attempt login
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user == null) {
        Fluttertoast.showToast(msg: "Login failed. Please try again.");
        return;
      }

      print("🟢 User logged in: ${user.uid}");

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        print("✅ Firestore User Data: $userData");

        Fluttertoast.showToast(
            msg: "Welcome back, ${userData['name']}!",
            gravity: ToastGravity.TOP);
      } else {
        print("❌ No user data found in Firestore");
        Fluttertoast.showToast(
            msg: "User data not found!", gravity: ToastGravity.TOP);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found with this email", gravity: ToastGravity.TOP);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Incorrect password", gravity: ToastGravity.TOP);
      } else {
        print("❌ FirebaseAuthException: ${e.code} - ${e.message}");
        Fluttertoast.showToast(
            msg: "Error: ${e.message}", gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print("❌ Unexpected Error: $e");
      Fluttertoast.showToast(msg: "Unexpected error occurred");
    }
  }
}
