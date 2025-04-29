import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Card Example'),
        ),
        body: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // Profile picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://www.example.com/profile.jpg', // Replace with your image URL
                  ),
                ),
                // Profile name and details
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text(
                    'Kalini Jithma',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Software Developer'),
                ),
                Divider(),
                // Contact information
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text('070-23-45678'),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.red),
                  title: Text('jithmakalini@gmail.com'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
