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
          title: Text('Draggable Container Example'),
        ),
        body: DragAndDropExample(),
      ),
    );
  }
}

class DragAndDropExample extends StatefulWidget {
  @override
  _DragAndDropExampleState createState() => _DragAndDropExampleState();
}

class _DragAndDropExampleState extends State<DragAndDropExample> {
  // Track if the item has been dropped
  bool isDropped = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Draggable Container
          Draggable<int>(
            data: 1, // The data passed when the container is dragged
            child: isDropped
                ? Container() // Hide the original item when dropped
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Drag me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
            feedback: Material(
              color: Colors.transparent,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue.withOpacity(0.5),
                child: Center(
                  child: Text(
                    'Drag me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(
              width: 100,
              height: 100,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
          SizedBox(width: 50),
          // DragTarget where the container can be dropped
          DragTarget<int>(
            onAccept: (data) {
              // Handle the data when the container is dropped
              setState(() {
                isDropped = true;
              });
              print('Container dropped with data: $data');
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200,
                height: 200,
                color: candidateData.isEmpty ? Colors.grey : Colors.green,
                child: Center(
                  child: Text(
                    candidateData.isEmpty ? 'Drop here' : 'Dropped!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
