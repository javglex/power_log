import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/services/exercise_service.dart';

class ExerciseEditRow extends StatefulWidget {

  final int exerciseId;
  final String workoutId;
  final int categoryId;
  Function(ExerciseRecord) callback;

  ExerciseEditRow({Key key, @required this.exerciseId, @required this.workoutId,
    @required this.categoryId, @required this.callback}) : super(key: key);

  @override
  _ExerciseRow createState() => _ExerciseRow();
}

class _ExerciseRow extends State<ExerciseEditRow> {
  static const padding_column_title = 24.0;
  String textFieldName = '';
  var setsEditingController = TextEditingController();
  var repsEditingController = TextEditingController();
  var weightEditingController = TextEditingController();
  ExerciseService exerciseService;
  ExerciseRecord newExerciseRecord;

  @override
  void initState(){
    exerciseService = ExerciseService();
    Exercise exercise = exerciseService.getExerciseById(widget.exerciseId);
    if (exercise!=null && exercise.description!=null)
      setState(() {
        textFieldName = exercise.description;
      });

    setsEditingController.text = '0';
    repsEditingController.text = '0';
    weightEditingController.text = '0';

    newExerciseRecord = ExerciseRecord(exerciseid: widget.exerciseId,
        workoutid: widget.workoutId, categoryid: widget.categoryId);
    
    setsEditingController.addListener(_updateSets);
    repsEditingController.addListener(_updateReps);
    weightEditingController.addListener(_updateWeight);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    repsEditingController.dispose();
    setsEditingController.dispose();
    weightEditingController.dispose();
    super.dispose();
  }
  
  _updateSets(){
    try {
      newExerciseRecord.sets = int.parse(setsEditingController.text);
      widget.callback(newExerciseRecord);
    }catch(e){

    }
    print("updated sets");
  }

  _updateReps(){
    try {
      newExerciseRecord.reps = int.parse(repsEditingController.text);
      widget.callback(newExerciseRecord);
    }catch(e){

    }
    print("updated reps");
  }

  _updateWeight(){
    try {
      newExerciseRecord.weight = int.parse(weightEditingController.text);
      widget.callback(newExerciseRecord);
    }catch(e){

    }
    print("updated weight");
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
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: setsEditingController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Sets",
                                fillColor: Colors.blueGrey
                            )
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: repsEditingController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Reps",
                                fillColor: Colors.blueGrey
                            )
                          ),

                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: weightEditingController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Weight",
                                fillColor: Colors.blueGrey
                            )
                          ),
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
