import 'package:flutter/material.dart';
class tabexample extends StatefulWidget {
  const tabexample({super.key});

  @override
  State<tabexample> createState() => _tabexampleState();
}

class _tabexampleState extends State<tabexample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs:[
              Tab(icon: Icon(Icons.home),text: 'Home',),
              Tab(icon: Icon(Icons.settings),text: 'setting',),
              Tab(icon: Icon(Icons.message_sharp),text: 'message',),
            ]
          ),
        ),
        body: const TabBarView(children:[
          Center(child: Text('Message')),
        ]),
      ),
    );
  }
}
