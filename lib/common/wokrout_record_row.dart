import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/pages/CreateWorkoutPage.dart';
import 'package:power_log/pages/WorkoutRecordDetail.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';

class RecordRow extends StatefulWidget {
  final String workoutId;

  RecordRow({Key key, @required this.workoutId}) : super(key: key);

  @override
  _RecordRow createState() => _RecordRow();
}

class _RecordRow extends State<RecordRow> {
  static const padding_column_title = 24.0;
  String textFieldName = '';
  String textFieldDate = '';
  WorkoutRecord record;
  WorkoutRecordService workoutRecordService;
  ExerciseService exerciseService;

  @override
  void initState(){
    workoutRecordService = WorkoutRecordService();
    exerciseService = ExerciseService();

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: _openDetailPage,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Icon(
                Icons.lens,
                color: record.colorHex!=null?Color(record.colorHex):Colors.blue,
                size: 36.0,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(textFieldName,
                  style: TextStyle(
                      fontSize: 20.0)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: Text(textFieldDate,
                        style: TextStyle(
                            fontSize: 16.0)
                    ),
                  )
                ]
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.blue[200],
              size: 36.0,
            ),
          ],
        ),
      ),
    );
  }

  _openDetailPage(){
    print("creating workout record detail page..");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutRecordDetail(workoutId: record.id))
    );
  }
}
