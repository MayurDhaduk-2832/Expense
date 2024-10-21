import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';

class FiChartPage extends StatefulWidget {
  const FiChartPage({Key? key}) : super(key: key);

  @override
  _FiChartPageState createState() => _FiChartPageState();
}

class _FiChartPageState extends State<FiChartPage> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: false,
              drawVerticalLine: false,
            ),
            titlesData: FlTitlesData(
              show: false,
              bottomTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
              leftTitles:AxisTitles(),
            ),
            maxX: 8,
            maxY: 8,
            minY: 0,
            minX: 0,
            lineBarsData: [
              LineChartBarData(
                  spots: [
                    const FlSpot(0, 2),
                    const FlSpot(2, 4),
                    const FlSpot(3, 3),
                    const FlSpot(5, 5),
                    const FlSpot(7, 6),
                    const FlSpot(8, 4),
                  ],
                  isCurved: true,
                  color: AppColors.buttonColor,
                  barWidth: 5,
                  belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          colors: [
                            AppColors.buttonColor.withOpacity(0.24),
                            AppColors.buttonColor.withOpacity(0),
                          ],
                          stops: [0.0, 1.0],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.clamp
                      )

                  )
              )
            ]
        )
    );
  }
}