import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:power_log/common/exercise_row.dart';
import 'package:power_log/pages/AddExercisePage.dart';

class CreateWorkoutPage extends StatefulWidget {
  @override
  _CreateWorkoutPage createState() => _CreateWorkoutPage();
}

class _CreateWorkoutPage extends State<CreateWorkoutPage> {
  var dateTxt = TextEditingController();
  static const padding_column_title = 24.0;
  var selectedExercises = [];
  static const body_padding = 18.0;

  @override
  void initState() {
    dateTxt.text = DateFormat('MMMM dd yyyy').format(selectedDate);

    super.initState();
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
                        controller: dateTxt,
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
                  child: selectedExercises.length != 0
                      ? ListView.builder(
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: selectedExercises.length,
                          itemBuilder: (BuildContext context, int index) {
                            var exercise;
                            if (selectedExercises.length != 0)
                              exercise = selectedExercises[index];
                            return selectedExercises.length != 0
                                ? ExerciseRow(exerciseId: exercise)
                                : Text("Add some exercises");
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text("Add some exercises",
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black54)),
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
            "Add Exercise",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: _addExercisePage,
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

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
        dateTxt.text = DateFormat('MMMM dd yyyy').format(selectedDate);
      });
  }

  Future<void> _addExercisePage() async {
    print("_addExercisePage..");
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExercisePage()),
    );

    setState(() {
      selectedExercises = result;
    });

    print("result from add exercise page: ");
    print(result);
  }
}
