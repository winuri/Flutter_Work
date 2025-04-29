import 'package:flutter/material.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatefulWidget {
@override
State createState() => _MyAppState();
}

     class _MyAppState extends State {
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('GridView with Images')),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
          mainAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: List.generate(4, (index) {
        return Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 5),
      ],
      ),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
        child: Image.asset('pasta.jpeg',
        fit: BoxFit.cover,
        
    ),
      ),
    );
  }),
  ),
  ),
  );
  }
}