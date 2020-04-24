import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseRow extends StatefulWidget {
  final String exerciseId;

  ExerciseRow({Key key, @required this.exerciseId}) : super(key: key);

  @override
  _ExerciseRow createState() => _ExerciseRow();
}

class _ExerciseRow extends State<ExerciseRow> {
  static const padding_column_title = 24.0;

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
                    child: Text("Exercise: " + widget.exerciseId)
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Sets",
                                fillColor: Colors.blueGrey),
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Reps",
                                fillColor: Colors.blueGrey),
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
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                border: OutlineInputBorder(),
                                hintText: "Weight",
                                fillColor: Colors.blueGrey),
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
