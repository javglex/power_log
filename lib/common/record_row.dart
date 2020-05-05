import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/services/exercise_service.dart';

class RecordRow extends StatefulWidget {
  final String exerciseId;

  RecordRow({Key key, @required this.exerciseId}) : super(key: key);

  @override
  _RecordRow createState() => _RecordRow();
}

class _RecordRow extends State<RecordRow> {
  static const padding_column_title = 24.0;
  String textFieldName = '';
  ExerciseRecord record;
  ExerciseService exerciseService;

  @override
  void initState(){
    exerciseService = ExerciseService(context);
    record = exerciseService.getExerciseRecordById(widget.exerciseId);
    if (record!=null && record.exerciseid!=null) {
      Exercise exercise = exerciseService.getExerciseById(record.exerciseid);
      if (exercise!=null && exercise.description!=null)
        setState(() {
          textFieldName = exercise.description;
        });
    }

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    exerciseService.updateExerciseRecord(record);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: padding_column_title, top: padding_column_title, right: padding_column_title),
          child: Column(
            children: <Widget>[
              Row(children: [
                Expanded(
                    child: Text(textFieldName)
                ),
                InkWell(
                    onTap: ()=>{},
                    child: Icon(Icons.more_vert)
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(children: [Text("Sets")]),
                  ),
                  Expanded(
                    child: Column(children: [Text("Reps")]),
                  ),
                  Expanded(
                    child: Column(children: [Text("Weight")]),
                  ),
                  Expanded(child: Text(""))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Container(
                          child: Text(record.sets.toString())
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(record.reps.toString())
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(record.weight.toString())
                        ),
                      ),
                    ]),
                  ),
                  Expanded(child: Text("Lbs"))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
