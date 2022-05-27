import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PopLineChart extends StatefulWidget {
  const PopLineChart({Key? key}) : super(key: key);

  @override
  State<PopLineChart> createState() => _PopLineChartState();
}

class _PopLineChartState extends State<PopLineChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 1,
          minY: 0,
          maxX: 100,
        lineBarsData: [LineChartBarData(spots: [ FlSpot(1, 3),
          FlSpot(2.6, 2),])]
          ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
    ;
    ;
  }
}
