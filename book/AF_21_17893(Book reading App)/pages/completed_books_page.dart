import 'package:flutter/material.dart';

class CompletedBooksPage extends StatefulWidget {
  final List<Map<String, String>> completedBooks;

  const CompletedBooksPage({super.key, required this.completedBooks});

  @override
  _CompletedBooksPageState createState() => _CompletedBooksPageState();
}

class _CompletedBooksPageState extends State<CompletedBooksPage> {
  void _deleteBook(int index) {
    final removedBook = widget.completedBooks[index];

    // Show confirmation dialog before deleting the book
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Book'),
          content: Text('Are you sure you want to delete "${removedBook['title']}" from Completed Books?'),
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
                  widget.completedBooks.removeAt(index);
                });

                // Show SnackBar after the book is deleted
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${removedBook['title']} removed from Completed Books.'),
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
        title: Text('Completed Books'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.completedBooks.isEmpty
            ? Center(child: Text('No completed books yet.'))
            : ListView.builder(
                itemCount: widget.completedBooks.length,
                itemBuilder: (context, index) {
                  final book = widget.completedBooks[index];
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
