import 'package:flutter/material.dart';
import 'package:money_tracker/analytics.dart';
import 'package:money_tracker/login.dart';
// import 'login.dart'; // Import the login page file
// import 'analytics.dart'; // Import the analytics page file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // removes the debug banner
      title: 'Login Demo',
      theme: ThemeData.dark(), // optional dark theme
      home: LoginPage(), // Set LoginPage as the home screen
      // home: AnalyticsPage(), // Set LoginPage as the home screen
      routes: {
        // '/dashboard': (context) => DashboardPage(), // Example route
        '/analytics': (context) => AnalyticsPage(), // Route to AnalyticsPage
      },
    );
  }
}

// Example Dashboard Page (you can replace this later with your actual screen)
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(child: Text("Welcome to Dashboard!")),
    );
  }
}
