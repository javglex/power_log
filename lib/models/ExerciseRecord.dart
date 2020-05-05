import 'package:uuid/uuid.dart';

/**
 * ExerciseHistory is an exercise recorded by the user.
 * So it will include sets, reps, weight, equipment used etc.
 * A list of exerciseHistory will make up a workout.
 */

class ExerciseRecord{
  String id;
  String workoutid;
  int exerciseid;
  int equipmentid;
  int bartypeid;
  int sets;
  int reps;
  int weight;

  ExerciseRecord({this.workoutid,this.exerciseid,this.equipmentid,
    this.bartypeid,this.sets,this.reps,this.weight
  }){

    this.id = new Uuid().v1();
    this.sets = 0;
    this.reps = 0;
    this.weight = 0;
  }




}