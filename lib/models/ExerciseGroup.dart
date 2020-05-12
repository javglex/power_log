import 'Exercise.dart';


/**
 * Exercises holds a list of exercises by group. For example,
 * if the groupname is chest, and the group list will include exercises
 * that fall under that group
 */

class Exercises {
  final List<dynamic> groupedExercises;
  final String groupName;

  Exercises._({this.groupedExercises, this.groupName});

  factory Exercises.fromJson(Map<String, dynamic> json, String name) {
    return new Exercises._(
        groupedExercises: json['exercises'][name],
        groupName: name
    );
  }
}