import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseGroup.dart';
import 'dart:convert';

import 'package:power_log/services/exercise_service.dart';

class AddExercisePage extends StatefulWidget {
  @override
  _AddExercisePage createState() => _AddExercisePage();
}

class _AddExercisePage extends State<AddExercisePage> {
  Map<int, bool> _selectionMap = {};
  List<int> selectedExercises = [];
  Map<String, List<Exercise>> exerciseList = {};
  ExerciseService exerciseService;

  @override
  void initState() {
    exerciseService = ExerciseService();
    exerciseService.getExerciseList(context).then((val) => _finished(val));
    super.initState();
  }

  void _finished(val) {
    setState(() {
      exerciseList = val;
    });
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
            var groupList = exerciseList[groupNames[index]]
                .toList(); // should be outside build function
            return ExpansionTile(
              title: Text(groupNames[index]),
              children: List.generate(groupList.length, (i) {
                _selectionMap[groupList[i].id] =
                    _selectionMap[groupList[i].id] ?? false;
                return CheckboxListTile(
                  title: Text(groupList[i].description),
                  value: _selectionMap[groupList[i].id],
                  onChanged: (val) {
                    setState(() {
                      _selectionMap[groupList[i].id] = val;
                      _updateList();
                    });
                  },
                );
              }),
            );
          },
        )),
        bottomNavigationBar: RaisedButton(
          color: Colors.deepOrange,
          splashColor: Colors.yellow[200],
          animationDuration: Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 24.0, left: 32.0, right: 32.0, bottom: 24.0),
            child: Text(
              "Add Selected (" + selectedExercises.length.toString() + ")",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          onPressed: _sendList,
        ));
  }

  void _updateList() {
    selectedExercises = (Map<int, bool>.from(_selectionMap)
          ..removeWhere((k, v) => v == false))
        .keys
        .toList();
  }

  void _sendList() {
    print("addexercises page send list:");
    print(selectedExercises);
    selectedExercises = selectedExercises==null?[]:selectedExercises;
    Navigator.pop(context, selectedExercises);
  }
}
