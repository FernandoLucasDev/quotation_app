import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation/utils/bid_formatters.dart';
import 'package:quotation/utils/colors.dart';

class GraphicSkeleton extends StatelessWidget {
  List<dynamic> dataForChart;
  final int daysForChart;
  final Map<String, bool> isCurrencyValuation;

  GraphicSkeleton({super.key, required this.dataForChart, required this.daysForChart, required this.isCurrencyValuation});

  List<dynamic>  getFilteredData() {
    dataForChart = dataForChart.reversed.toList();
    if (daysForChart == 1) {
      return [dataForChart.first];
    }
    return dataForChart.sublist(dataForChart.length - daysForChart).toList();
  }

  String formatTimestamp(String timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    return DateFormat("dd").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = getFilteredData();
    final spots = filteredData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return FlSpot(index.toDouble(), double.parse(data['bid']));
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= filteredData.length) return Container();
                  final timestamp = filteredData[value.toInt()]['timestamp'];
                  final date = formatTimestamp(timestamp);
                  return Text(
                    date,
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Text(
                      dataForChart[14]["code"] == "BTC" ? value.toStringAsFixed(2).substring(0, 3) : value.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: (isCurrencyValuation[daysForChart.toString()] ?? true) ? upTextColor : downTextColor,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: (isCurrencyValuation[daysForChart.toString()] ?? true) ? upTextColor.withOpacity(0.3) : downTextColor.withOpacity(0.3),
              ),
            ),
          ],
          // lineTouchData: LineTouchData(
          //   touchTooltipData: LineTouchTooltipData(
          //     getTooltipItems: (spot, _, __, ___) {
          //       final date = formatTimestamp(filteredData[spot.x.toInt()]['timestamp']);
          //       return LineTooltipItem(
          //         "Dia: $date\nBid: ${spot.y.toStringAsFixed(2)}",
          //         const TextStyle(color: Colors.white),
          //       );
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }
}