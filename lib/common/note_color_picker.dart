


import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class NoteColorPicker extends StatefulWidget {

  final Function(ColorSwatch) colorCallback;

  NoteColorPicker({this.colorCallback}) : super();

  _NoteColorPicker createState() => _NoteColorPicker();

}

class _NoteColorPicker extends State<NoteColorPicker> {
  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch _tempMainColor;

  var customColors = [
    Colors.blue,
    Colors.red,
    Colors.deepOrange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.lightBlueAccent,
  ];

  ColorSwatch _mainColor;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: content),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _mainColor = _tempMainColor;
                  widget.colorCallback(_mainColor);
                });
              },
            ),
          ],
        );
      },
    );
  }


  void _openMainColorPicker() async {
    _openDialog(
      "Main Color picker",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        colors: customColors
      ),
    );
  }

  @override
  void initState(){
    _mainColor = customColors[0];

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: CircleAvatar(
                    backgroundColor: _mainColor,
                    radius: 11.0,
                  ),
                  radius: 14.0
                ),
                onTap: _openMainColorPicker,
              ),
            ],
          ),
        ],
      );
  }
}