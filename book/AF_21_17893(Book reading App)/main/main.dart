
import 'package:flutter/material.dart';
import 'package:my_book_app/pages/login_page.dart';  // Import login page
import 'package:my_book_app/pages/home_page.dart';  // Import HomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LoginPage(),  // Initial screen is the LoginPage
      routes: {
        '/home': (context) => HomePage(), // Named route for HomePage
        '/login': (context) => LoginPage(), // Named route for LoginPage
      },
    );
  }
}
