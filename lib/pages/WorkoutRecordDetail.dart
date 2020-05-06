import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';

/**
 * Displays important info on a workout record
 */

class WorkoutRecordDetail  extends StatefulWidget {
  final String workoutId;

  WorkoutRecordDetail({Key key, @required this.workoutId}) : super(key: key);

  @override
  _WorkoutRecordDetail createState() => _WorkoutRecordDetail();
}

class _WorkoutRecordDetail extends State<WorkoutRecordDetail> {
  static const padding_column_title = 24.0;
  String textFieldName = '';
  String textFieldDate = '';
  WorkoutRecord record;
  WorkoutRecordService workoutRecordService;
  ExerciseService exerciseService;

  @override
  void initState(){
    workoutRecordService = WorkoutRecordService(context);
    exerciseService = ExerciseService(context);

    record = workoutRecordService.getWorkoutRecordById(widget.workoutId);
    if (record!=null && record.name!=null && record.date!=null) {
      setState(() {
        textFieldName = record.name;
        textFieldName = StringUtils.capitalize(textFieldName);
        textFieldDate = DateFormat('MMMM dd yyyy').format(DateTime.parse(record.date));
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Details"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.lens,
                    color: Colors.blue,
                    size: 36.0,
                  ),
                  title: Text(
                      textFieldName,
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black)
                  ),
                  subtitle: Text(textFieldDate,
                      style: TextStyle(
                      fontSize: 14.0, color: Colors.black)
                  ),
                ),
                Text("This is a sample note that the user may have input" + record.notes)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
