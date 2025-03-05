import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authentication {
  final supabase = Supabase.instance.client;
  Future<void> signUp(String name, String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw 'Something went wrong. Try again later.';
      }

      final userId = response.user!.id;

      await supabase.from('users').insert({
        'id': userId,
        'name': name,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });

      Fluttertoast.showToast(
        msg: 'SignUp Successful',
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      print("Signup Error: $e");
      Fluttertoast.showToast(
        msg: "Sign Up failed",
        gravity: ToastGravity.TOP,
      );

      throw e;
    }
  }

  Future<bool> logIn(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      if (response.session == null) {
        throw 'Invalid email or password';
      }
      final userId = response.user!.id;
      final userData =
          await supabase.from('users').select().eq('id', userId).single();
      Fluttertoast.showToast(msg: "✅ Login Successful: ${userData['name']}");
      print("User logged in: ${userData['name']}");

      return true;
    } catch (e) {
      print("Login Error: $e");
      Fluttertoast.showToast(msg: "Login failed: ");
      return false;
    }
  }
}
