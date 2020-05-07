import 'package:flutter/material.dart';
import 'package:power_log/common/exercise_edit_row.dart';
import 'package:power_log/common/wokrout_record_row.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';

import 'CreateWorkoutPage.dart';

/**
 * Home page will hold workout logs
 */

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  List<WorkoutRecord> records;
  WorkoutRecordService workoutRecordService;
  @override
  void initState(){
    workoutRecordService = WorkoutRecordService(context);
    records = workoutRecordService.getWorkoutRecordList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Workout Log"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: records.length != 0
                      ? ListView.builder(
                    shrinkWrap: false,
                    physics: ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: records.length,
                    itemBuilder: (BuildContext context, int index) {
                      var recordid;
                      if (records.length != 0)
                        recordid = records[index].id;

                      return records.length != 0
                          ? RecordRow(workoutId: recordid)
                          : Text("Add some workouts");
                    },
                  )
                      : Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("Add some workouts",
                        style: TextStyle(
                            fontSize: 24, color: Colors.black54)),
                  )
              ),
            ]
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _createWorkoutPage,
            child: Icon(Icons.note_add),
            backgroundColor: Colors.blueGrey
        )
    );
  }

  void _createWorkoutPage(){
    print("creating workout page..");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
    );
  }

}