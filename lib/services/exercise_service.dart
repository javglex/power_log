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
  Map<int, int> categoryMap = Map<int,int>();  //given an exercise id, stores a category value
  
  ExerciseService._internal();

  static final ExerciseService _instance = ExerciseService._internal();

  factory ExerciseService(){
    if (_instance._exerciseList==null) {
      _instance._exerciseList = Map<String, List<Exercise>>();
    }
    return _instance;
  }



  _loadExerciseJson(BuildContext context) async {

    if (_exerciseList.values.length>0) //cached version already exists, abort loading
      return;

    String data = await DefaultAssetBundle.of(context).loadString('lib/assets/data/exercises.json');
    Map<String,dynamic> parsedJson = json.decode(data);


    Map<String,dynamic> exerciseGroups = parsedJson['exercises'];
    for (var entry in exerciseGroups.keys.toList()){
      Exercises exercisesGroups = Exercises.fromJson(parsedJson,entry);
      List<Exercise> exercises = [];

      for (Map<String,dynamic> json in exercisesGroups.groupedExercises) {
        Exercise exercise = Exercise.fromJson(json);
        exercises.add(exercise);
        categoryMap[exercise.id]=exercise.categoryId;
      }

      _exerciseList.addAll({entry.toString():exercises});
    }

  }

  Future<Map<String, List<Exercise>>> getExerciseList(BuildContext context) async{
    await _loadExerciseJson(context);
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
  
  int getExerciseCategory(int exerciseId){

    return categoryMap[exerciseId];
    
  }


}