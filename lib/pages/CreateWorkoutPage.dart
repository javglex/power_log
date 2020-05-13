import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:power_log/common/exercise_edit_row.dart';
import 'package:power_log/common/workout_edit_component.dart';
import 'package:power_log/models/Exercise.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/pages/AddExercisePage.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';

class CreateWorkoutPage extends StatefulWidget {
  @override
  _CreateWorkoutPage createState() => _CreateWorkoutPage();
}

class _CreateWorkoutPage extends State<CreateWorkoutPage> {
  var dateTxtCtrl = TextEditingController();
  var nameTxtCtrl = TextEditingController();
  var noteEditingCtrl = TextEditingController();

  static const padding_column_title = 24.0;
  static const body_padding = 18.0;

  List<int> selectedExercises = [];
  List<ExerciseRecord> exerciseRecords = [];
  ExerciseRecordService exerciseRecordService;
  WorkoutRecordService workoutRecordService;
  ExerciseService exerciseService;
  WorkoutRecord newWorkoutRecord;
  DateTime selectedDate = DateTime.now();
  int colorSelectedHex;
  String workoutNameText = "";
  String workoutNoteText = "";

  @override
  void initState() {
    exerciseRecordService = ExerciseRecordService();
    workoutRecordService = WorkoutRecordService();
    exerciseService = ExerciseService();

    newWorkoutRecord = WorkoutRecord();
    _addTxtListeners();

    super.initState();
  }

  _addTxtListeners() {
    nameTxtCtrl.addListener(_nameTxtChanged);
    noteEditingCtrl.addListener(_noteTxtChanged);
  }

  _nameTxtChanged() {
    workoutNameText = nameTxtCtrl.text;
  }

  _noteTxtChanged(){

    workoutNoteText = noteEditingCtrl.text;

  }


  @override
  void dispose() {
    nameTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Workout"),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft:Radius.circular(26.0),
                    bottomRight:Radius.circular(26.0),
                  ),
                ),
                elevation: 12.0,
                color: Colors.blue[300],
                child: WorkoutEditComponent(nameTxtCtrl:nameTxtCtrl,
                  dateTxtCtrl:dateTxtCtrl,
                  dateCallback: _dateCallback,
                  colorCallback: _colorCallback,
                  noteEditingCtrl: noteEditingCtrl
                )
              ),
              Expanded(
                  child: selectedExercises != null &&
                          selectedExercises.length != 0
                      ? ListView.builder(
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: exerciseRecords.length,
                          itemBuilder: (BuildContext context, int index) {
                            var recordid;
                            var categoryid;
                            if (exerciseRecords.length != 0) {
                              recordid = exerciseRecords[index].exerciseid;
                              categoryid = exerciseRecords[index].categoryid;
                            }

                            return selectedExercises.length != 0
                                ? ExerciseEditRow(
                                    exerciseId: recordid,
                                    workoutId: newWorkoutRecord.id,
                                    categoryId: categoryid,
                                    callback: (record) =>
                                        _exerciseRecordAdded(record, index))
                                : Text("Add some exercises");
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text("Add some exercises",
                                style: TextStyle(fontSize: 24)),
                          ),
                        )),
            ]),
      ),
      bottomNavigationBar: RaisedButton(
        color: Colors.deepOrange,
        splashColor: Colors.yellow[200],
        animationDuration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 8.0, right: 8.0, bottom: 24.0),
          child: Text(
            "Done",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: () => _finishAdding(context),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addExercisePage,
          child: Icon(Icons.note_add),
          backgroundColor: Colors.grey[300]),
    );
  }

  _colorCallback(ColorSwatch color){
    print("create workout page color callback: "+ color[400].value.toString());
    colorSelectedHex = color[400].value;
  }

  _dateCallback(DateTime dateSelected){
    selectedDate = dateSelected;
  }

  _exerciseRecordAdded(ExerciseRecord record, int index) {
    print("createworkoutpage added : ");
    print(record);
    print("with id: " + index.toString());
    exerciseRecords[index] = record;
  }

  Future<void> _addExercisePage() async {
    print("_addExercisePage..");
    List<int> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExercisePage()),
    );

    setState(() {
      selectedExercises = result;
      _createExerciseHistories();
    });

    print("result from add exercise page: ");
    print(result);
  }

  _finishAdding(BuildContext ctx) {
    if (exerciseRecords.length == 0) {
      showAlertDialog(ctx, "No exercises", "Add exercises before continuing");
      return;
    }

    //update the exercise service with the finalized record edits
    exerciseRecordService.addExerciseRecordsToList(exerciseRecords);

    newWorkoutRecord.date = selectedDate.toIso8601String();
    if (colorSelectedHex!=null)
      newWorkoutRecord.colorHex = colorSelectedHex;

    if (workoutNameText.length > 0 && workoutNameText != '')
      newWorkoutRecord.name = workoutNameText.trim();
    else
      newWorkoutRecord.name = 'Workout#' +
          DateTime.now().millisecondsSinceEpoch.toString().substring(9);

    if (workoutNoteText.length > 0 && workoutNoteText != '')
      newWorkoutRecord.notes = workoutNoteText.trim();

    workoutRecordService.addWorkoutRecordToList(newWorkoutRecord);
    Navigator.pop(context);
  }

  _createExerciseHistories() {
    if (selectedExercises == null) return;
    for (int id in selectedExercises) {
      int categoryId = exerciseService.getExerciseCategory(id);
      ExerciseRecord exerciseRecord =
          new ExerciseRecord(workoutid: newWorkoutRecord.id, exerciseid: id, categoryid: categoryId);
      exerciseRecords.add(exerciseRecord);
    }
  }

  // user defined function
  Future<void> showAlertDialog(
      BuildContext ctx, final String message, final String subMessage) async {
    // flutter defined function
    return showDialog<void>(
      context: ctx,
      builder: (BuildContext ctx) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(message),
          content: Text(subMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
