import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/injection_container.dart';
import 'package:flutter_application_1/presentation/pages/car_list_screen.dart';
// import 'package:flutter_application_1/utils/add_sample_data.dart'; // Commented out - uncomment if you need to reset Firebase
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'presentation/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initInjection();

  // 🚗 Clear old cars and add updated ones (run once, then comment out)
  // await clearAndAddCars();  // ⚠️ COMMENTED OUT - Uncomment only when you want to reset Firebase with sample data

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: OnboardingPage(),
    );
  }
}
