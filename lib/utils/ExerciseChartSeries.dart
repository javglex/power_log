import 'dart:collection';

import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';

/**
 * generates and holds analytical data to be displayed inside
 * the workout insights page
 */

class ExerciseChartSeries {



  SplayTreeMap<DateTime, double> exerciseMaxData(Map<DateTime, List> workoutsbyDate) {

    SplayTreeMap<DateTime, double> data = SplayTreeMap<DateTime,double>();
    ExerciseRecordService exerciseRecordService = ExerciseRecordService();

    workoutsbyDate.forEach((date,workouts) {

      int max  = 0;

      for (WorkoutRecord record in workouts){
        List<ExerciseRecord> exercises = exerciseRecordService.getExerciseRecordsByWorkoutId(record.id);
        List<ExerciseRecord> bodyExercises = exercises.where((l) => l.categoryid == 1).toList();
        if (bodyExercises.length>1)
          max = bodyExercises.reduce((curr, next) => curr.weight > next.weight? curr: next).weight;
        else if (bodyExercises.length==1)
          max = bodyExercises[0].weight;
      }

      data[date] = max.toDouble();

    });

    return data;
  }

}