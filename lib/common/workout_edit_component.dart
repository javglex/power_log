import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:power_log/common/note_color_picker.dart';
import 'package:power_log/pages/CreateWorkoutPage.dart';

class WorkoutEditComponent extends StatefulWidget {
  var dateTxtCtrl = TextEditingController();
  var nameTxtCtrl = TextEditingController();
  var noteEditingCtrl = TextEditingController();
  Function(ColorSwatch) colorCallback;
  Function(DateTime) dateCallback;

  WorkoutEditComponent(
      {Key key,
      @required this.dateTxtCtrl,
      @required this.nameTxtCtrl,
      @required this.dateCallback,
      @required this.noteEditingCtrl,
      @required this.colorCallback})
      : super(key: key);

  @override
  _ExerciseRow createState() => _ExerciseRow();
}

class _ExerciseRow extends State<WorkoutEditComponent> {
  static const body_padding = 18.0;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    widget.dateTxtCtrl.text = DateFormat('MMMM dd yyyy').format(selectedDate);

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
      padding: const EdgeInsets.only(
          top: 26.0, bottom: 26.0, left: 12.0, right: 12.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
//          child: Text("Workout Name", style: TextStyle(fontSize: 18)),
//        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: TextField(
                    controller: widget.nameTxtCtrl,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white70),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: "Workout Name",
                        fillColor: Colors.white),
                  ),
                ),
                Container(
                  width:
                      MediaQuery.of(context).size.width * .5 - body_padding * 2,
                  child: TextFormField(
                      controller: widget.dateTxtCtrl,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20.0),
                          prefixIcon: Icon(Icons.calendar_today),
                          border: InputBorder.none,
                          hintText: "Date",
                          fillColor: Colors.blueGrey),
                      onTap: () => _selectDate(context)),
                ),
              ],
            ),
        Padding(
          padding: const EdgeInsets.only(top: 64.0, bottom: 8.0, left: 8.0, right: 12.0),
          child: Row(
            children: <Widget>[
              Text("Note", style: TextStyle(fontSize: 18)),
              Spacer(flex: 1),
              NoteColorPicker(colorCallback: widget.colorCallback),
            ],
          ),
        ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: widget.noteEditingCtrl,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.white70),
                        border: OutlineInputBorder(),
                        hintText: "Workout summary...",
                        fillColor: Colors.grey
                    ),
                  maxLines: 25,
                  minLines: 5,
                ),
              ),
            ),
          ]),
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
        widget.dateTxtCtrl.text =
            DateFormat('MMMM dd yyyy').format(selectedDate);
        widget.dateCallback(selectedDate);
      });
  }
}
