import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  final Function(String, String, String, String, String) onBookSaved; // Callback function to pass data to HomePage

  AddBookPage({required this.onBookSaved}); // Constructor to accept the callback

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _description = '';
  String _rating = '';
  String _image = '';

  // Function to handle saving the book (you can modify it based on where you store the book data)
  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      // Save the book (For demonstration purposes, just printing the book details)
      print("Book Saved: $_title, $_author, $_description, $_rating, $_image");

      // Show the success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Save Successfully Done!")),
      );

      // Pass the book data back to the HomePage via the callback function
      widget.onBookSaved(_title, _author, _description, _rating, _image);

      // Go back to the HomePage after saving the book
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Book Title", "Please enter a book title", Icons.book, (value) {
                setState(() {
                  _title = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField("Author", "Please enter the author's name", Icons.person, (value) {
                setState(() {
                  _author = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField("Description", "Please enter a description", Icons.description, (value) {
                setState(() {
                  _description = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField("Rating (e.g., 4.5)", "Please enter a rating", Icons.star, (value) {
                setState(() {
                  _rating = value;
                });
              }),
              SizedBox(height: 16),
              _buildTextField("Book Image URL", "Please enter an image URL", Icons.image, (value) {
                setState(() {
                  _image = value;
                });
              }),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 242, 242, 244), // Background color for the button
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: Icon(Icons.save, size: 24), // Icon for the button
                  label: Text(
                    'Save Book',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Bold text for the button
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to reduce code duplication for creating text fields
  Widget _buildTextField(String label, String errorMessage, IconData icon, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.indigo), // Icon for each text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.indigo, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
