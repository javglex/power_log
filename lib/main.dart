import 'package:flutter/material.dart';
import 'package:power_log/pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
       children: [
         Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          image: DecorationImage(
            image: AssetImage("lib/assets/kisspng-barbell.png"),
            fit: BoxFit.cover,
          ),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex:1),
            Text(
                "Power Log",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 64,
                  color:  Colors.white,
                  fontWeight: FontWeight.bold
                ),
            ),
            Spacer(flex:1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                        border: OutlineInputBorder(),
                        hintText: "Username",
                        fillColor: Colors.blueGrey
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top:10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        fillColor: Colors.blueGrey
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex:1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      textColor: Colors.white,
                      child: Text("SIGN IN"),
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
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                      onTap: ()=> print("forgot"),
                      child:Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                      )
                  ),
                ),
              ],
            ),
            Spacer(flex:2),
          ],
        )],
      ),
    );
  }

  void _signIn(){
    print("signing in..");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

}
