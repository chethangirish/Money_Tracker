import 'package:flutter/material.dart';
import 'package:money_tracker/analytics.dart';
import 'package:money_tracker/login.dart'; // contains LoginPage
import 'package:money_tracker/dashboard.dart'; // contains DashboardPage

void main() {
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      title: 'Money Tracker',
      theme: ThemeData.dark(), // optional dark theme
      home: const LoginPage(), // Start with LoginPage
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/analytics': (context) => const AnalyticsPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
