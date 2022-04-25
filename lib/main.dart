import 'package:flutter/material.dart';
import 'package:student_reward_system/screens/dashboard.dart';
import 'package:student_reward_system/screens/home.dart';

void main(List<String> args) {
  runApp(const StudentRewardSystemApp());
}

class StudentRewardSystemApp extends StatelessWidget {
  const StudentRewardSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(
        isRegistration: false,
      ),
      initialRoute: '/home',
      routes: {
        "/home": (context) => const HomePage(
              isRegistration: false,
            ),
        "/register": (context) => const HomePage(
              isRegistration: true,
            )
      },
    );
  }
}
