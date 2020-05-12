import 'package:uuid/uuid.dart';

/**
 * A workout class will hold a list of exercise records
 */
class WorkoutRecord{

  String id; //uniqueId
  String name;
  String date;
  String notes;
  int colorHex; //icon that will show up in our calendar/list

  WorkoutRecord(){
    this.colorHex = 4282557941;
    this.id = new Uuid().v1();
    this.notes = "";
  }

}