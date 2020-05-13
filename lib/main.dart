import 'package:flutter/material.dart';
import 'package:power_log/pages/HomePage.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:power_log/services/exercise_record_service.dart';
import 'package:power_log/services/exercise_service.dart';
import 'package:power_log/services/workout_service.dart';
import 'package:power_log/testing/mock_create_data.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          brightness: Brightness.light,
          hintColor: Colors.cyan),
      home: LoginPage(title: 'PowerLog'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  
  @override
  void initState(){
    super.initState();
    ExerciseRecordService exerciseService = ExerciseRecordService();
    WorkoutRecordService workoutService = WorkoutRecordService();
    MockWorkoutData mockData = MockWorkoutData();
    workoutService.addWorkoutRecordsToList(mockData.createAndFetchWorkouts(context, 135,280));
    exerciseService.addExerciseRecordsToList(mockData.fetchExerciseRecords());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[800].withOpacity(.5),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("lib/assets/powerlog.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 1),
                  Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    child: Text("Username",
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                              border: UnderlineInputBorder(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                ),
                                  borderSide: BorderSide(color: Colors.white, width: 10.0)),
                              hintText: "",
                              fillColor: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    child: Text("Password",
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "",
                              fillColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 60.0,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: Colors.black54,
                          child: Text("SIGN IN"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          onPressed: _signIn,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        padding: EdgeInsets.all(16),
                        child: InkWell(
                            onTap: () => print("forgot"),
                            child: Text("Forgot Password?",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0))),
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signIn() {
    print("signing in..");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
