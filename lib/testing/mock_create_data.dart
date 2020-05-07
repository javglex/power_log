import 'dart:math';

import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:uuid/uuid.dart';

/**
 * Will populate dummy data to be displayed in app for testing purposes
 */


class MockWorkoutData{

  List<WorkoutRecord> _workoutRecords;
  List<ExerciseRecord> _exerciseRecords;

  void _generateWorkoutRecords(int size){


    for (int i = 0; i < size; i++){
      String name = 'Workout#' + DateTime.now().millisecondsSinceEpoch.toString().substring(9);
      final _random = new Random();
      int min = -5;
      int max = 4;
      int next(min, max) => min + _random.nextInt(max - min);

      String date = DateTime.now().add(Duration(days: next(min,max))).toIso8601String();
      WorkoutRecord record = WorkoutRecord();
      record.date = date;
      record.name = name;

      _workoutRecords.add(record);
    }

  }

  void _generateExerciseRecords(int size){

    for (int i = 0; i < size; i++){

      final _random = new Random();
      int min = 1;
      int max = 15;
      int next(min, max) => min + _random.nextInt(max - min);

      int min2 = 0;
      int max2 = _workoutRecords.length;
      int next2(min2, max2) => min2 + _random.nextInt(max2 - min2);

      ExerciseRecord record = ExerciseRecord();
      record.exerciseid = next(min, max);
      record.workoutid = _workoutRecords.elementAt(next2(min2,max2)).id;

      _exerciseRecords.add(record);
    }

  }


  /**
   * size = size of workout list to generate
   * size2 = size of exercise list to generate
   */
  List<WorkoutRecord> createAndFetchWorkouts(int size, int size2){

    _workoutRecords = [];
    _exerciseRecords = [];

    _generateWorkoutRecords(size);
    if(_workoutRecords.length>0)
      _generateExerciseRecords(size2);
    if (_workoutRecords.length>0 && _exerciseRecords.length>0)
      return this._workoutRecords;
    else return [];
  }

  List<ExerciseRecord> fetchExerciseRecords(){
    return this._exerciseRecords;
  }

}