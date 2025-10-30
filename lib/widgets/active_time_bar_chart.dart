import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ActiveTimeChartWithTitle extends StatefulWidget {
  const ActiveTimeChartWithTitle({Key? key}) : super(key: key);

  @override
  _ActiveTimeChartWithTitleState createState() =>
      _ActiveTimeChartWithTitleState();
}

class _ActiveTimeChartWithTitleState extends State<ActiveTimeChartWithTitle> {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 3;

  @override
  Widget build(BuildContext context) {
    final ticks = [7, 14, 21, 28, 35];
    final features = ["12", "02", "04", "06", "08", "10"];
    final data = [
      [10.0, 20, 28, 5, 16, 15],
      [14.5, 1, 4, 14, 23, 10]
    ];

    // Adjust features and data based on the number of features
    final adjustedFeatures = features.sublist(0, numberOfFeatures.floor());

    // Convert data to List<List<double>>
    final adjustedData = data
        .map((graph) => graph
            .sublist(0, numberOfFeatures.floor())
            .map((value) =>
                value.toDouble()) // Ensure all values are of type double
            .toList())
        .toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLineChart(adjustedFeatures, adjustedData),
        ],
      ),
    );
  }

  Widget _buildLineChart(List<String> features, List<List<double>> data) {
    return Expanded(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: false),
          lineBarsData: _getLineChartData(features, data),
        ),
      ),
    );
  }

  List<LineChartBarData> _getLineChartData(
      List<String> features, List<List<double>> data) {
    List<LineChartBarData> lineBarsData = [];
    lineBarsData.add(
      LineChartBarData(
        spots: List.generate(features.length, (index) {
          return FlSpot(index.toDouble(), data[0][index]);
        }),
        isCurved: true,
        color: Colors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData:
            BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
      ),
    );
    lineBarsData.add(
      LineChartBarData(
        spots: List.generate(features.length, (index) {
          return FlSpot(index.toDouble(), data[1][index]);
        }),
        isCurved: true,
        color: Colors.orange,
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData:
            BarAreaData(show: true, color: Colors.orange.withOpacity(0.3)),
      ),
    );

    return lineBarsData;
  }
}
