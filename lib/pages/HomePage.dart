import 'package:flutter/material.dart';

import 'CreateWorkoutPage.dart';

/**
 * Home page will hold workout logs
 */

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Workout Log"),
        ),
        body: Center(

        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _createWorkoutPage,
            child: Icon(Icons.note_add),
            backgroundColor: Colors.blueGrey
        )
    );
  }

  void _createWorkoutPage(){
    print("creating workout page..");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
    );
  }

}