import 'Exercise.dart';

class Exercises {
  final List<dynamic> group;
  final String groupName;

  Exercises._({this.group, this.groupName});

  factory Exercises.fromJson(Map<String, dynamic> json, String name) {
    return new Exercises._(
        group: json['exercises'][name],
        groupName: name
    );
  }
}