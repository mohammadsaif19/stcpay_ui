import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stc_pay/const/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'repeated_widgets.dart';

//Following code will represent the gauge chart of transactions
Widget gaugeChartWidget() {
  return Stack(
    children: [
      SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            canScaleToFit: true,
            showLabels: false,
            showFirstLabel: true,
            minimum: 0,
            maximum: 100,
            startAngle: 150,
            endAngle: 35,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 20,
                color: const Color(0xFFFE2A25),
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.25,
                endWidth: 0.25,
              ),
              GaugeRange(
                startValue: 20,
                endValue: 50,
                color: const Color(0xFFFFBA00),
                startWidth: 0.25,
                endWidth: 0.25,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 50,
                endValue: 70,
                color: GREEN_COLOR,
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.25,
                endWidth: 0.25,
              ),
              GaugeRange(
                startValue: 70,
                endValue: 100,
                color: Colors.deepPurple,
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.25,
                endWidth: 0.25,
              ),
            ],
          )
        ],
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(25),
            RichText(
              text: const TextSpan(
                text: 'SAR ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: "2,199",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.red,
                ),
                horizontalSpace(10),
                const Text(
                  "Above average",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

//Following code will represent the graph chart of transactions
List<Color> gradientColors = [
  PRIMARY_COLOR,
  GREEN_COLOR,
];

Widget lineChartWidget() {
  return LineChart(
    LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w500, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Nov';
              case 5:
                return 'Dec';
              case 8:
                return 'Jan';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1k';
              case 3:
                return '3k';
              case 5:
                return '5k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    ),
  );
}
