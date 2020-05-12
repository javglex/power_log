import 'dart:collection';

import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:flutter/material.dart';

import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:power_log/services/workout_service.dart';
import 'package:power_log/utils/ExerciseChartSeries.dart';
import 'package:power_log/utils/fake_chart_series.dart';

/**
 * loads and displays analytical data into a line chart
 */
class WorkoutInsightsPage extends StatefulWidget {

  @override
  _WorkoutInsightsPage createState() => _WorkoutInsightsPage();
}

class _WorkoutInsightsPage extends State<WorkoutInsightsPage> with FakeChartSeries, ExerciseChartSeries {
  int chartIndex = 0;
  Map<DateTime, List> workoutsbyDate;


  @override
  void initState(){
    super.initState();
    workoutsbyDate = WorkoutRecordService().groupWorkoutsByDate();
  }

  @override
  Widget build(BuildContext context) {


    Map<DateTime, double> line1 = createLine2();
    Map<DateTime, double> line2 = createLine2_2();
    SplayTreeMap<DateTime, double> exerciseMaxes = exerciseMaxData(workoutsbyDate);

    LineChart chart;

    if (chartIndex == 0) {
      chart = LineChart.fromDateTimeMaps(
          [exerciseMaxes], [Colors.green], ['lbs'],
          tapTextFontWeight: FontWeight.w400);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("OY"),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height/2.0,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right: 32.0),
                    child: AnimatedLineChart(
                      chart,
                      key: UniqueKey(),
                    ), //Unique key to force animations
                  )),
            ]),
      ),
    );
  }
}