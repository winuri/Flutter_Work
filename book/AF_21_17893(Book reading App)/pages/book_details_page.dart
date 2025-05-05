import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final Map<String, String> book;
  final VoidCallback onAddToReading;
  final VoidCallback onMarkAsCompleted;

  BookDetailsPage({
    required this.book,
    required this.onAddToReading,
    required this.onMarkAsCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book['title']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(book['image']!, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(
              book['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Author: ${book['author']}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              book['description']!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onAddToReading,
                  child: Text('Add to Current Reading'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Change color as needed
                  ),
                ),
                ElevatedButton(
                  onPressed: onMarkAsCompleted,
                  child: Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change color as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
