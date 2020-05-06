import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:power_log/common/exercise_row.dart';
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

  static const padding_column_title = 24.0;
  static const body_padding = 18.0;

  List<int> selectedExercises = [];
  List<ExerciseRecord> exerciseRecords = [];
  ExerciseRecordService exerciseRecordService;
  WorkoutRecordService workoutRecordService;
  WorkoutRecord newWorkoutRecord;

  DateTime selectedDate = DateTime.now();
  String workoutNameText = "";

  @override
  void initState() {
    dateTxtCtrl.text = DateFormat('MMMM dd yyyy').format(selectedDate);
    exerciseRecordService = ExerciseRecordService(context);
    workoutRecordService = WorkoutRecordService(context);

    newWorkoutRecord = WorkoutRecord();
    _addTxtListeners();

    super.initState();
  }

  _addTxtListeners(){
    nameTxtCtrl.addListener(_nameTxtChanged);
  }

  _nameTxtChanged(){
    workoutNameText =  nameTxtCtrl.text;
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
      body: Padding(
        padding: EdgeInsets.all(body_padding),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Text("Workout Name",
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-body_padding*2,
                    child: TextField(
                      controller: nameTxtCtrl,
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black45),
                          border: OutlineInputBorder(),
                          hintText: "Workout name",
                          fillColor: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Text("Date",
                style : TextStyle(fontSize: 18, color: Colors.black54)),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-body_padding*2,
                    child: TextFormField(
                        controller: dateTxtCtrl,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.black45),
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                            hintText: "Date",
                            fillColor: Colors.blueGrey),
                        onTap: () => _selectDate(context)),
                  ),
                ],
              ),
              Expanded(
                  child: selectedExercises != null && selectedExercises.length!=0
                      ? ListView.builder(
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: exerciseRecords.length,
                          itemBuilder: (BuildContext context, int index) {
                            var recordid;
                            if (exerciseRecords.length != 0)
                              recordid = exerciseRecords[index].exerciseid;

                            return selectedExercises.length != 0
                                ? ExerciseRow(exerciseId: recordid, callback: (record)=> _exerciseRecordAdded(record,index))
                                : Text("Add some exercises");
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text("Add some exercises",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black54)),
                          ),
                        )
              ),
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
        onPressed: ()=>_finishAdding(context),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addExercisePage,
          child: Icon(Icons.note_add),
          backgroundColor: Colors.blueGrey
      ),
    );
  }


  Future<Null> _selectDate(BuildContext context) async {
    FocusScope.of(context)
        .requestFocus(new FocusNode()); //prevent keyboard from appearing

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateTxtCtrl.text = DateFormat('MMMM dd yyyy').format(selectedDate);
      });
  }

  _exerciseRecordAdded(ExerciseRecord record, int index){
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

  _finishAdding(BuildContext ctx){

    if (exerciseRecords.length==0){
      showAlertDialog(ctx,"No exercises","Add exercises before continuing");
      return;
    }

    //update the exercise service with the finalized record edits
    exerciseRecordService.addExerciseRecordsToList(exerciseRecords);
    
    newWorkoutRecord.date = selectedDate.toIso8601String();
    if (workoutNameText.length>0 && workoutNameText!='')
      newWorkoutRecord.name = workoutNameText.trim();
    else
      newWorkoutRecord.name = 'Workout#' + DateTime.now().millisecondsSinceEpoch.toString().substring(9);

    workoutRecordService.addWorkoutRecordToList(newWorkoutRecord);
    Navigator.pop(context);
  }

  _createExerciseHistories(){
    for (int id in selectedExercises){
      ExerciseRecord exerciseRecord = new ExerciseRecord(workoutid: newWorkoutRecord.id,exerciseid: id );
      exerciseRecords.add(exerciseRecord);
    }
  }

  // user defined function
  Future<void> showAlertDialog(BuildContext ctx, final String message, final String subMessage) async {
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
