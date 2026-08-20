import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main(){
  runApp(myflutter());
}

class myflutter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal
      ),
      home: dashboard(),
    );
  }
}

class dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => myhomepage();
}
class myhomepage extends State<dashboard>{

  //int second = 0;
  int milliseconds = 0;
  final laps = <int>[];
  late Timer timer;
  bool isRunning = false;


  void _lap(){
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    print(laps);
  }

  void _clear(){
    setState(() {
      laps.clear();
      milliseconds = 0;
    });
  }

  Widget _builderCounter(BuildContext context){
    return    Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),

          Text(_milliseconds(milliseconds),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTick(Timer timer){
    setState(() {
      if(isRunning){
        // second++;
        milliseconds += 100;
      }
    });
  }

  void _startTimer(){
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);
    setState(() {
      //second = 0;
      milliseconds = 0;
      isRunning = true;
    });
  }

  void _stopTimer(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String _milliseconds(milis){
    final seconds = milis / 1000;
    return '$seconds seconds';
  }

  void _pauseTimer(){
    setState(() {
      isRunning = false;
    });
  }

  void _resumeTimer(){
    setState(() {
      isRunning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Stopwatch")),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_milliseconds(milliseconds),style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: isRunning ? null : _startTimer,
                      child: Text("Start")),

                  ElevatedButton(onPressed: isRunning ? _stopTimer : null,
                      child: Text("Stop")),

                  ElevatedButton(onPressed: isRunning ? null : _resumeTimer,
                      child: Text("Resume")),

                  ElevatedButton(onPressed: isRunning ? _pauseTimer : null,
                      child: Text("Pause")),
                ],
              ),

              ElevatedButton(onPressed: _lap, child: Text("Lap")),
              ElevatedButton(onPressed: _clear, child: Text("Clear")),


            ],
          )),
    );
  }
}