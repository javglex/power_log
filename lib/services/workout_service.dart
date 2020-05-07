

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

  Map<DateTime, List> groupWorkoutsByDate(){

    Map<DateTime, List> workoutMap = Map<DateTime, List>();

    for (WorkoutRecord record in _workoutRecordList){
      DateTime recordDate = DateTime.parse(record.date);
      recordDate = new DateTime(recordDate.year, recordDate.month, recordDate.day, 0, 0, 0);  //round off time
      List<WorkoutRecord> list = [];

      if (workoutMap.containsKey(recordDate)){
        list = workoutMap[recordDate];
        list.add(record);
      } else {
        list.add(record);
      }

      workoutMap[recordDate] = list;

    }

    return workoutMap;

  }

  List<WorkoutRecord> getWorkoutRecordsByDate(String date){
    DateTime searchDateBeg = DateTime.parse(date);
    DateTime searchDateEnd = DateTime.parse(date);
    searchDateBeg = new DateTime(searchDateBeg.year, searchDateBeg.month, searchDateBeg.day, 0, 0, 0);
    searchDateEnd = new DateTime(searchDateEnd.year, searchDateEnd.month, searchDateEnd.day, 23, 59, 59);
    List<WorkoutRecord> workoutRecords = [];
    print("workoutservice returned original list size "+_workoutRecordList.length.toString());

    for (WorkoutRecord record in _workoutRecordList){
      DateTime recordDate = DateTime.parse(record.date);
      if(recordDate.compareTo(searchDateBeg)==0 || (recordDate.isAfter(searchDateBeg) && recordDate.isBefore(searchDateEnd))) {
        workoutRecords.add(record);
        print("workout service searchDateBeg: " + searchDateBeg.toIso8601String()
            + " enddate: " + searchDateEnd.toIso8601String()
            + " recordDate: " + recordDate.toIso8601String());
      }

    }
    print("workoutservice returned "+workoutRecords.length.toString());
    return workoutRecords;
  }

}