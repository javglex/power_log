

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseGroup.dart';
import 'package:power_log/models/ExerciseRecord.dart';

class ExerciseService{

  List<ExerciseRecord> _exerciseHistoryList;
  Map<String,List<Exercise>> _exerciseList;   //available exercises, by group
  BuildContext context;

  ExerciseService._internal();

  static final ExerciseService _instance = ExerciseService._internal();

  factory ExerciseService(BuildContext ctx){
    if (_instance.context==null) {
      _instance.context = ctx;
      _instance._exerciseHistoryList = List<ExerciseRecord>();
      _instance._exerciseList = Map<String, List<Exercise>>();
    }
    return _instance;
  }



  _loadExerciseJson() async {
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
    print("this shit called" + _exerciseList.length.toString());

    for (String group in _exerciseList.keys.toList()){
      print("group: " + group);

      for (Exercise e  in _exerciseList[group]) {
        print("exercise id: " + e.id.toString() + "search id " + id.toString());
        if (e.id == id)
          return e;
      }
    }

    return null;
  }

  
  void updateExerciseRecord(ExerciseRecord r){

    for (ExerciseRecord record in _exerciseHistoryList){
      if (r.id==record.id)
        record=r;
    }

  }
  
  void setExerciseRecordList(List<ExerciseRecord> list){
    this._exerciseHistoryList = list;
  }

  void addExerciseRecordToList(ExerciseRecord exerciseRecord){
    this._exerciseHistoryList.add(exerciseRecord);
  }

  void addExerciseRecordsToList(List<ExerciseRecord> exerciseRecords){
    for (ExerciseRecord record in exerciseRecords)
      this._exerciseHistoryList.add(record);
  }

  List<ExerciseRecord> getExerciseRecordList(){
    return this._exerciseHistoryList;
  }

  ExerciseRecord getExerciseRecordAt(int i){
    return _exerciseHistoryList.elementAt(i);
  }

  ExerciseRecord getExerciseRecordById(String id){

    for (ExerciseRecord e in _exerciseHistoryList){
      if (e.id==id)
        return e;
    }

    return null;
  }

}