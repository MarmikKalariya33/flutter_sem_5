import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(myflutter());
}

class myflutter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey
      ),
      home: dashboard(),
    );
  }
}

class dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Myhomepage();
}

class Myhomepage extends State<dashboard>{

  var color = [Colors.lightGreenAccent,Colors.blue,Colors.pink,Colors.tealAccent];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Color Page")),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: [
            Expanded(child: Container(color: color[(count + 0) % 4])),
            Expanded(child: Container(color: color[(count + 1) % 4])),
            Expanded(child: Container(color: color[(count + 2) % 4])),
            Expanded(child: Container(color: color[(count + 3) % 4])),

            Expanded(
              child: ElevatedButton(
                // This is anonymous Function
                  onPressed: (){
                    setState(() {
                      count++;
                      print("button clicked");
                    });
                  }, child: Text("Click")),
            )
          ],
        )
    );
  }
}