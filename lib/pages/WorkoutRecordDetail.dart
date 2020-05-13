import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:power_log/common/exercise_row.dart';
import 'package:power_log/common/wokrout_record_row.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/services/exercise_record_service.dart';
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
  WorkoutRecord workoutRecord;
  List<ExerciseRecord> exerciseRecords;
  WorkoutRecordService workoutRecordService;
  ExerciseRecordService exerciseRecordService;

  @override
  void initState(){
    workoutRecordService = WorkoutRecordService();
    exerciseRecordService = ExerciseRecordService();

    workoutRecord = workoutRecordService.getWorkoutRecordById(widget.workoutId);
    if (workoutRecord!=null && workoutRecord.name!=null && workoutRecord.date!=null) {
      setState(() {
        textFieldName = workoutRecord.name;
        textFieldName = StringUtils.capitalize(textFieldName);
        textFieldDate = DateFormat('MMMM dd yyyy').format(DateTime.parse(workoutRecord.date));
        print("WorkoutDetail recordate: "+ workoutRecord.date.toString());
      });
    }

    if (workoutRecord.id!=null && workoutRecord.id.length>0){
      setState(() {
        print("workoutrecord detail called set state");
        exerciseRecords = exerciseRecordService.getExerciseRecordsByWorkoutId(
            workoutRecord.id);
        print("workoutrecord exerciserecords fetched size: " + exerciseRecords.length.toString());

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
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                bottomLeft:Radius.circular(26.0),
                bottomRight:Radius.circular(26.0),
              ),
            ),
            elevation: 12.0,
            color: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
//                    leading: Icon(
//                      Icons.lens,
//                      color: Colors.blue,
//                      size: 36.0,
//                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Text(
                          textFieldName,
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.white)
                      ),
                    ),
                    subtitle: Text(textFieldDate,
                        style: TextStyle(
                        fontSize: 16.0, color: Colors.white70)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16.0, right: 8.0, top:16.0, bottom:16.0),
                    child: Text("This is a sample note that the user may have input: " + workoutRecord.notes,
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.white)
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: (exerciseRecords!=null&&exerciseRecords.length != 0)
                  ? ListView.builder(
                shrinkWrap: false,
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: exerciseRecords.length,
                itemBuilder: (BuildContext context, int index) {
                  var recordid;
                  if (exerciseRecords.length != 0)
                    recordid = exerciseRecords[index].id;

                  return ExerciseRow(exerciseId: recordid);

                },
              )
                  : Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("No exercises recorded for this workout",
                    style: TextStyle(
                        fontSize: 24)),
              )
          ),
        ],
      ),
    );
  }
}
