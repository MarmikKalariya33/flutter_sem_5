import 'package:flutter/material.dart';

class gridExample extends StatefulWidget {
  const gridExample({super.key});

  @override
  State<gridExample> createState() => _gridExampleState();
}

class _gridExampleState extends State<gridExample> {
  final topics =[
    'topic 1',
    'topic 2',
    'topic 3',
    'topic 4',
    'topic 5',
    'topic 6',
    'topic 7',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount:2,
          crossAxisSpacing:6,
          mainAxisSpacing:6,
          children:[
            for(final topic in topics)
              Card(
                color:Colors.blue.shade400,
                child: Center(
                  child: Text(topic),
                ),
              )
          ]
        ),
      ),
    );
  }
}
