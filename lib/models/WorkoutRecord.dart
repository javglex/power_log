import 'package:uuid/uuid.dart';

/**
 * A workout class will hold a list of exercise records
 */
class WorkoutRecord{

  String id; //uniqueId
  String name;
  String date;
  String notes;
  int symbolId; //icon that will show up in our calendar/list

  WorkoutRecord(){
    this.symbolId = 0;
    this.id = new Uuid().v1();
    this.notes = "";
  }

}