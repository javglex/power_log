import 'package:flutter/material.dart';
import 'package:power_log/common/calendar_component.dart';
import 'package:power_log/common/exercise_edit_row.dart';
import 'package:power_log/common/wokrout_record_row.dart';
import 'package:power_log/models/ExerciseRecord.dart';
import 'package:power_log/models/WorkoutRecord.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';
import 'package:uuid/uuid.dart';

import 'CreateWorkoutPage.dart';

/**
 * Home page will hold workout logs
 */

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  List<WorkoutRecord> records;
  WorkoutRecordService workoutRecordService;
  DateTime dateSelected = DateTime.now();

  @override
  void initState(){
    workoutRecordService = WorkoutRecordService();
    records = workoutRecordService.getWorkoutRecordsByDate(dateSelected.toIso8601String());
    super.initState();
  }

  Future<Null> _dateCallback(DateTime date) async{
    print("homepage datecallback: "+date.toIso8601String());
    dateSelected = date;

    List<WorkoutRecord> fetchedRecords =  workoutRecordService.getWorkoutRecordsByDate(dateSelected.toIso8601String());

    setState(() {
      records = fetchedRecords;
      if(records.length>0)
        print(records[0].date + records[0].name);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Workout Logs"),
        ),
        body: CustomScrollView(
          key: Key(DateTime.now().toString()),
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: false,
              floating: true,
              titleSpacing: 0,
              elevation: 1.0,
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height * 0.55 ,
              flexibleSpace: FlexibleSpaceBar(
                background: CalendarComponent(title: "TestCalendar", dateCallback: _dateCallback),
              ),

            ),
            SliverList(
                delegate: new SliverChildListDelegate(_buildList())
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _createWorkoutPage,
            child: Icon(Icons.note_add),
            backgroundColor: Colors.grey[300]
        )
    );
  }

  //          Column(
//            children: [
//              CalendarComponent(title: "TestCalendar", dateCallback: _dateCallback),
//              Expanded(
//                  child: records.length != 0
//                      ? ListView.separated(
//                    key: Key(DateTime.now().toString()),
//                    shrinkWrap: false,
//                    physics: ClampingScrollPhysics(),
//                    padding: const EdgeInsets.all(8.0),
//                    itemCount: records.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      final recordid = records[index]?.id;
//                      return RecordRow(workoutId: recordid);
//                    },
//                    separatorBuilder: (context, index) {
//                      return Divider(color: Colors.grey,);
//                    },
//                  )
//                      : Padding(
//                    padding: EdgeInsets.all(32.0),
//                    child: Text("No workouts on this day",
//                        style: TextStyle(
//                            fontSize: 24)),
//                  )
//              ),
//            ]
//          ),

  List _buildList() {
    List<Widget> listItems = List();

    for (int i = 0; i < records.length; i++) {
      final recordid = records[i]?.id;
      listItems.add(Column( children: [
        RecordRow(workoutId: recordid),
        (i!=records.length-1 )? Divider(color: Colors.grey): Divider(color: Colors.transparent)
      ]));
    }


    return listItems;
  }

  Future<void> _createWorkoutPage() async {
    print("creating workout page..");
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
    );

    _dateCallback(dateSelected);

  }

}