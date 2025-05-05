import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for name, email (Replace these with actual data)
    _nameController.text = 'John Doe';
    _emailController.text = 'johndoe@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Placeholder (No update functionality here)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://www.w3schools.com/w3images/avatar2.png'),
            ),
            SizedBox(height: 20),
            // Update Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Update Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Update Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your new password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Confirm Password
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Save Changes Button
            ElevatedButton(
              onPressed: _saveProfileChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save profile changes (name, email, password, confirm password)
  void _saveProfileChanges() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        // Save profile changes here (e.g., send to backend or local storage)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        // If passwords don't match, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }
}
