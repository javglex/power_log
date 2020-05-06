/**
 * Holds user created exercise records
 */

import 'package:flutter/material.dart';
import 'package:power_log/models/ExerciseRecord.dart';

class ExerciseRecordService{

  List<ExerciseRecord> _exerciseHistoryList;
  BuildContext context;

  ExerciseRecordService._internal();

  static final ExerciseRecordService _instance = ExerciseRecordService._internal();

  factory ExerciseRecordService(BuildContext ctx){
    if (_instance.context==null) {
      _instance.context = ctx;
      _instance._exerciseHistoryList = List<ExerciseRecord>();
    }
    return _instance;
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