import 'package:flutter/material.dart';

class CurrentReadingListPage extends StatefulWidget {
  final List<Map<String, String>> currentReadingBooks;

  const CurrentReadingListPage({super.key, required this.currentReadingBooks});

  @override
  _CurrentReadingListPageState createState() => _CurrentReadingListPageState();
}

class _CurrentReadingListPageState extends State<CurrentReadingListPage> {
  void _deleteBook(int index) {
    final removedBook = widget.currentReadingBooks[index];

    // Show confirmation dialog before deleting the book
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Book'),
          content: Text('Are you sure you want to delete "${removedBook['title']}" from Current Reading?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.currentReadingBooks.removeAt(index);
                });

                // Show SnackBar after the book is deleted
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${removedBook['title']} removed from Current Reading.'),
                    backgroundColor: Colors.red,
                  ),
                );

                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Reading'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.currentReadingBooks.isEmpty
            ? Center(child: Text('No books in current reading list.'))
            : ListView.builder(
                itemCount: widget.currentReadingBooks.length,
                itemBuilder: (context, index) {
                  final book = widget.currentReadingBooks[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(book['image']!, width: 50, fit: BoxFit.cover),
                      title: Text(book['title']!),
                      subtitle: Text(book['author']!),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBook(index),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
