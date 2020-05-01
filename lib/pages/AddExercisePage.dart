
import 'package:flutter/material.dart';

class AddExercisePage extends StatefulWidget {

  @override
  _AddExercisePage createState() => _AddExercisePage();
}


class _AddExercisePage extends State<AddExercisePage> {
  Map<String, bool> _selectionMap = {};
  List<dynamic> selectedExercises = [];

  var exerciseList = [
    {
      "services": [
        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Leg Curl",
          "id": 229
        },        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Leg Press",
          "id": 229
        },        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Barbell Squat",
          "id": 229
        },
      ],
      "name": "Legs",
      "is_active": false,
      "id": 22
    },
    {
      "services": [
        {
          "service_group_id": 22,
          "service_category": "B",
          "name": "Barbell Bench Press",
          "id": 228
        },
        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Dumbell Bench Press",
          "id": 229
        },        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Smartbell Bench Press",
          "id": 229
        },        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Barbell Floor Press",
          "id": 229
        },        {
          "service_group_id": 22,
          "service_category": "W",
          "name": "Incline Barbell Bench Press",
          "id": 229
        },
      ],
      "name": "Chest",
      "is_active": false,
      "id": 22
    },
    {
      "services": [
        {
          "service_group_id": 19,
          "service_category": "B",
          "name": "Barbell Deadlist",
          "id": 193
        },
        {
          "service_group_id": 19,
          "service_category": "B",
          "name": "Barbell Row",
          "id": 194
        },
        {
          "service_group_id": 19,
          "service_category": "B",
          "name": "Rack Pull",
          "id": 194
        },
        {
          "service_group_id": 19,
          "service_category": "B",
          "name": "Lat Pulldown",
          "id": 194
        }
      ],
      "name": "Back",
      "is_active": false,
      "id": 19
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add an Exercise"),
        ),
        body: Center(
            child: ListView.builder(
              shrinkWrap: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: exerciseList.length,
              itemBuilder: (BuildContext context, int index) {
                var item = exerciseList[index]; // should be outside build function
                List items = item['services']; // should be outside build function
                return ExpansionTile(
                  title: Text(item['name']),
                  children: List.generate(items.length, (i) {
                    _selectionMap[items[i]['name']] =
                        _selectionMap[items[i]['name']] ?? item['is_active'];
                    return CheckboxListTile(
                      title: Text(items[i]['name']),
                      value: _selectionMap[items[i]['name']],
                      onChanged: (val) {
                        setState(() {
                          _selectionMap[items[i]['name']] = val;
                          _updateList();
                        });
                      },
                    );
                  }),
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
            onPressed: ()=>{},
            child: Icon(Icons.note_add),
            backgroundColor: Colors.blueGrey
        ),
      bottomNavigationBar:  RaisedButton(
        color: Colors.deepOrange,
        splashColor: Colors.yellow[200],
        animationDuration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 32.0, right: 32.0, bottom: 24.0),
          child: Text(
            "Add Selected ("+selectedExercises.length.toString()+")",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: _sendList,
      )
    );
  }

  void _updateList(){
    selectedExercises =  (Map.from(_selectionMap)..removeWhere((k, v) => v==false)).keys.toList();

  }

  void _sendList(){
    print(selectedExercises);
    Navigator.pop(context);
  }

}