/**
 * Holds available exercises users can select from
 */

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseGroup.dart';
import 'package:power_log/models/ExerciseRecord.dart';

class ExerciseService{

  Map<String,List<Exercise>> _exerciseList;   //available exercises, by group
  BuildContext context;

  ExerciseService._internal();

  static final ExerciseService _instance = ExerciseService._internal();

  factory ExerciseService(BuildContext ctx){
    if (_instance.context==null) {
      _instance.context = ctx;
      _instance._exerciseList = Map<String, List<Exercise>>();
    }
    return _instance;
  }



  _loadExerciseJson() async {

    if (_exerciseList.values.length>0) //cached version already exists, abort loading
      return;

    String data = await DefaultAssetBundle.of(context).loadString('lib/assets/data/exercises.json');
    Map<String,dynamic> parsedJson = json.decode(data);


    Map<String,dynamic> exerciseGroups = parsedJson['exercises'];
    for (var entry in exerciseGroups.keys.toList()){
      Exercises exercisesGroups = Exercises.fromJson(parsedJson,entry);
      List<Exercise> exercises = [];

      for (Map<String,dynamic> json in exercisesGroups.group)
        exercises.add(Exercise.fromJson(json));

      _exerciseList.addAll({entry.toString():exercises});
    }

  }

  Future<Map<String, List<Exercise>>> getExerciseList() async{
    await _loadExerciseJson();
    print("exercise service finished loading exercise json: " + _exerciseList.length.toString());
    return _exerciseList;
  }

  Exercise getExerciseById(int id){

    for (String group in _exerciseList.keys.toList()){

      for (Exercise e  in _exerciseList[group]) {
        if (e.id == id)
          return e;
      }
    }

    return null;
  }


}