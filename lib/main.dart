import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_to_mate/StateMangment/ChangeScreenProvider.dart';
import 'package:travel_to_mate/StateMangment/imageSelector.dart';

import 'package:travel_to_mate/views/Login&SignUp/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mufvkzotaedzcuxcykin.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im11ZnZrem90YWVkemN1eGN5a2luIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEwOTczMzAsImV4cCI6MjA1NjY3MzMzMH0.d8MhuCPzznoJ6gkD644s11pKECCLq-O0O7muGhSvaYQ',
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ChnageScreenProvider()),
    ChangeNotifierProvider(create: (_) => Imageselector()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
