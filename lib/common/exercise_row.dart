

import 'package:flutter/material.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';

class ExerciseRow extends StatefulWidget {

  final String exerciseId;

  ExerciseRow({Key key, @required this.exerciseId}) : super(key: key);

  @override
  _ExerciseRow createState() => _ExerciseRow();
}

class _ExerciseRow extends State<ExerciseRow> {
  static const padding_column_title = 24.0;
  String exerciseTextName = '';
  ExerciseRecordService exerciseRecordService;
  ExerciseService exerciseService;
  ExerciseRecord exerciseRecord;
  @override
  void initState(){
    exerciseRecordService = ExerciseRecordService();
    exerciseService = ExerciseService();
    exerciseRecord = exerciseRecordService.getExerciseRecordById(widget.exerciseId);
    if (exerciseRecord!=null && exerciseRecord.exerciseid!=null)
      setState(() {
        int id = exerciseRecord.exerciseid;
        if(exerciseService.getExerciseById(id)!=null)
          exerciseTextName = exerciseService.getExerciseById(id).description;
      });

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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: padding_column_title, top: padding_column_title, right: padding_column_title),
          child: Column(
            children: <Widget>[
              Row(children: [
                Expanded(
                    child: Text(exerciseTextName)
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
                          child: Text(exerciseRecord.sets.toString())
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(exerciseRecord.reps.toString())
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(exerciseRecord.weight.toString())
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
