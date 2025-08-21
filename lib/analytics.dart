import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Analytics Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Spendings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Wrap(
                spacing: 30,
                runSpacing: 30,
                children: List.generate(4, (index) {
                  return Container(
                    height: 70,
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFFFFFFF),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.directions_car, color: Colors.white, size: 30),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "₹2000",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Key Finance Metrics",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: List.generate(3, (index) {
                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    title: const Text(
                      "Emergency Fund",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Text(
                      "₹2500",
                      style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            const Text(
              "Monthly Expense",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 2000,
                      color: Color(0xFF40BF77),
                      title: "Shopping\n4000",
                      radius: 100,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    PieChartSectionData(
                      value: 4000,
                      color: Color(0xFF00F56B),
                      title: "Food\n4500",
                      radius: 100,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    PieChartSectionData(
                      value: 4000,
                      color: Color(0xFF2D8653),
                      title: "Travel\n2000",
                      radius: 100,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Daily Expenses",

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 300,
                width: 350,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value % 500 == 0) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 1:
                                return Text(
                                  "Mon",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 2:
                                return Text(
                                  "Tue",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 3:
                                return Text(
                                  "Wed",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 4:
                                return Text(
                                  "Thu",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 5:
                                return Text(
                                  "Fri",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 6:
                                return Text(
                                  "Sat",
                                  style: TextStyle(color: Colors.white),
                                );
                              case 7:
                                return Text(
                                  "Sun",
                                  style: TextStyle(color: Colors.white),
                                );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(toY: 1500, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(toY: 1200, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(toY: 1800, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(toY: 1000, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(toY: 2200, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(toY: 4200, color: Colors.green),
                        ],
                      ),
                      BarChartGroupData(
                        x: 7,
                        barRods: [
                          BarChartRodData(toY: 6000, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
