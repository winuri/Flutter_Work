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
          title: Text('ListView.builder Example'),
        ),
        body: ItemList(),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length, // Number of items in the list
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(items[index]),
            leading: Icon(Icons.list),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle item tap here (for example, navigate to a new screen)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${items[index]}')),
              );
            },
          ),
        );
      },
    );
  }
}
