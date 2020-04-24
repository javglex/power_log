import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_log/common/exercise_row.dart';

class CreateWorkoutPage extends StatefulWidget {
  @override
  _CreateWorkoutPage createState() => _CreateWorkoutPage();
}

class _CreateWorkoutPage extends State<CreateWorkoutPage> {
  var dateTxt = TextEditingController();
  static const padding_column_title = 24.0;

  @override
  void initState() {
    dateTxt.text = selectedDate.toIso8601String();

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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, right: 8.0, left: 8.0, bottom:8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.7,
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
              ),
              ExerciseRow(
                  exerciseId: "test123"
              ),
              ExerciseRow(
                  exerciseId: "test113"
              ),
              Padding(
                padding: const EdgeInsets.only(top: padding_column_title),
                child: RaisedButton(
                  color: Colors.deepOrange,
                  splashColor: Colors.yellow[200],
                  animationDuration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, left: 32.0, right: 32.0, bottom: 24.0),
                    child: Text(
                      "Add Exercise",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ]),
          ),
        ));
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
        dateTxt.text = selectedDate.toIso8601String();
      });
  }
}
