

import 'package:flutter/material.dart';
import 'package:power_log/models/WorkoutRecord.dart';

class WorkoutRecordService{

  List<WorkoutRecord> _workoutRecordList;
  BuildContext context;

  WorkoutRecordService._internal();

  static final WorkoutRecordService _instance = WorkoutRecordService._internal();

  factory WorkoutRecordService(BuildContext ctx){
    if (_instance.context==null) {
      _instance.context = ctx;
      _instance._workoutRecordList = List<WorkoutRecord>();
    }
    return _instance;
  }


  void updateWorkoutRecord(WorkoutRecord r){

    for (WorkoutRecord record in _workoutRecordList){
      if (r.id==record.id)
        record=r;
    }

  }

  void setWorkoutRecordList(List<WorkoutRecord> list){
    this._workoutRecordList = list;
  }

  void addWorkoutRecordToList(WorkoutRecord exerciseRecord){
    this._workoutRecordList.add(exerciseRecord);
  }

  void addWorkoutRecordsToList(List<WorkoutRecord> exerciseRecords){
    for (WorkoutRecord record in exerciseRecords)
      this._workoutRecordList.add(record);
  }

  List<WorkoutRecord> getWorkoutRecordList(){
    return this._workoutRecordList;
  }

  WorkoutRecord getWorkoutRecordAt(int i){
    return _workoutRecordList.elementAt(i);
  }

  WorkoutRecord getWorkoutRecordById(String id){

    for (WorkoutRecord e in _workoutRecordList){
      if (e.id==id)
        return e;
    }

    return null;
  }

}