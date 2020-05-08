import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:power_log/services/workout_service.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class CalendarComponent extends StatefulWidget {


  final String title;
  final Function(DateTime) dateCallback;
  final DateTime selectedDate;

  CalendarComponent({Key key, this.title, this.dateCallback, this.selectedDate}) : super(key: key);

  @override
  _CalendarComponent createState() => _CalendarComponent();
}

class _CalendarComponent extends State<CalendarComponent> with TickerProviderStateMixin {

  Map<DateTime, List> _events=Map<DateTime, List>();
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  WorkoutRecordService workoutService;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    workoutService = WorkoutRecordService();

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    setState(() {
      _events = workoutService.groupWorkoutsByDate();
      _selectedDay = widget.selectedDate==null?DateTime.now():widget.selectedDate;
      print("calendar component init: "+_selectedDay.toIso8601String());

    });

  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected' + day.toIso8601String());
    if (events.length>0)
      print("events "+  events[0].toString());
    setState(() {
      _selectedEvents = events;
      _selectedDay=day;
      widget.dateCallback(day);
    });

  }

  void _onHeaderTapped(DateTime t){
    setState(() {
      _events = workoutService.groupWorkoutsByDate();
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last,
      CalendarFormat format) {

    print('CALLBACK: _onCalendarCreated'+first.toIso8601String()+" "+last.toIso8601String());
    _calendarController.setSelectedDay(_selectedDay);

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft:Radius.circular(16.0),
          bottomRight:Radius.circular(16.0),
        ),
      ),
      color: Colors.blueGrey,
      child: _buildTableCalendar(),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.deepOrange[400]),
          weekendStyle:  TextStyle(color: Colors.deepOrange[500])
      ),
      calendarStyle: CalendarStyle(
        weekendStyle: TextStyle(color: Colors.grey[200]),
        outsideWeekendStyle:  TextStyle(color: Colors.grey[400]),
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.grey[400],
        markersColor: Colors.orangeAccent,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onHeaderTapped: _onHeaderTapped,
      onCalendarCreated: _onCalendarCreated,
    );
  }

}