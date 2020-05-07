/**
 * Holds user created exercise records
 */

import 'package:flutter/material.dart';
import 'package:power_log/models/ExerciseRecord.dart';

class ExerciseRecordService{

  List<ExerciseRecord> _exerciseRecordList;

  ExerciseRecordService._internal();

  static final ExerciseRecordService _instance = ExerciseRecordService._internal();

  factory ExerciseRecordService(){
    if (_instance._exerciseRecordList==null) {
      _instance._exerciseRecordList = List<ExerciseRecord>();
    }
    return _instance;
  }


  void updateExerciseRecord(ExerciseRecord r){

    for (ExerciseRecord record in _exerciseRecordList){
      if (r.id==record.id)
        record=r;
    }

  }

  void setExerciseRecordList(List<ExerciseRecord> list){
    this._exerciseRecordList = list;
  }

  void addExerciseRecordToList(ExerciseRecord exerciseRecord){
    this._exerciseRecordList.add(exerciseRecord);
  }

  void addExerciseRecordsToList(List<ExerciseRecord> exerciseRecords){
    for (ExerciseRecord record in exerciseRecords)
      this._exerciseRecordList.add(record);
  }

  List<ExerciseRecord> getExerciseRecordList(){
    return this._exerciseRecordList;
  }

  ExerciseRecord getExerciseRecordAt(int i){
    return _exerciseRecordList.elementAt(i);
  }
  
  List<ExerciseRecord> getExerciseRecordsByWorkoutId(String id){
    List<ExerciseRecord> records = [];
    print("exersicerecordservice list size: " + _exerciseRecordList.length.toString());
    for (int i = 0; i<_exerciseRecordList.length; i++){
      if (id==_exerciseRecordList.elementAt(i).workoutid)
        records.add(_exerciseRecordList.elementAt(i));
    }

    return records;
  }

  ExerciseRecord getExerciseRecordById(String id){

    for (ExerciseRecord e in _exerciseRecordList){
      if (e.id==id)
        return e;
    }

    return null;
  }

}