
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/Exercises.dart';
import 'dart:convert';

class AddExercisePage extends StatefulWidget {

  @override
  _AddExercisePage createState() => _AddExercisePage();
}


class _AddExercisePage extends State<AddExercisePage> {
  Map<String, bool> _selectionMap = {};
  List<dynamic> selectedExercises = [];
  Map<String,List<Exercise>> exerciseList = {};

  @override
  void initState() {
    _loadJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add an Exercise"),
        ),
        body: Center(
            child: ListView.builder(
              shrinkWrap: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: exerciseList.keys.length,
              itemBuilder: (BuildContext context, int index) {
                var groupNames = exerciseList.keys.toList();
                var groupList = exerciseList[groupNames[index]].toList(); // should be outside build function
                return ExpansionTile(
                  title: Text(groupNames[index]),
                  children: List.generate(groupList.length, (i) {
                    _selectionMap[groupList[i].description] =
                        _selectionMap[groupList[i].description] ?? false;
                    return CheckboxListTile(
                      title: Text(groupList[i].description),
                      value: _selectionMap[groupList[i].description],
                      onChanged: (val) {
                        setState(() {
                          _selectionMap[groupList[i].description] = val;
                          _updateList();
                        });
                      },
                    );
                  }),
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
            onPressed: ()=>{},
            child: Icon(Icons.note_add),
            backgroundColor: Colors.blueGrey
        ),
      bottomNavigationBar:  RaisedButton(
        color: Colors.deepOrange,
        splashColor: Colors.yellow[200],
        animationDuration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 32.0, right: 32.0, bottom: 24.0),
          child: Text(
            "Add Selected ("+selectedExercises.length.toString()+")",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: _sendList,
      )
    );
  }

  void _updateList(){
    selectedExercises =  (Map.from(_selectionMap)..removeWhere((k, v) => v==false)).keys.toList();

  }

  void _sendList(){
    print(selectedExercises);
    Navigator.pop(context, selectedExercises);
  }

  _loadJson() async {
    String data = await DefaultAssetBundle.of(context).loadString('lib/assets/data/exercises.json');
    Map<String,dynamic> parsedJson = json.decode(data);


    Map<String,dynamic> exerciseGroups = parsedJson['exercises'];
    for (var entry in exerciseGroups.keys.toList()){
      Exercises exercisesGroups = Exercises.fromJson(parsedJson,entry);
      List<Exercise> exercises = [];

      for (Map<String,dynamic> json in exercisesGroups.group)
        exercises.add(Exercise.fromJson(json));
      exerciseList.addAll({entry.toString():exercises});
    }

    setState(() {


    });
  }

}