import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/text_styles.dart';
import 'package:smartbudget/core/utils/constants/spacing.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';

class ChartSection extends StatelessWidget {
  final HomeCubit cubit;

  const ChartSection({super.key, required this.cubit});

  // Define a larger palette of colors
  static const List<Color> chartColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.brown,
    Colors.lime,
    Colors.deepOrange,
    Colors.lightBlue,
    Colors.blueGrey,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    if (cubit.categoryExpenses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Text(
          'Expenses Breakdown',
          style: TextStylesManager.bold18,
        ),
        verticalSpace20,
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: _getSections(),
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
        verticalSpace20,
        _buildLegend(),
      ],
    );
  }

  List<PieChartSectionData> _getSections() {
    int index = 0;
    return cubit.categoryExpenses.entries.map((entry) {
      final color = chartColors[index % chartColors.length];
      index++;
      final percentage = (entry.value / cubit.totalExpense) * 100;

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: TextStylesManager.bold12.copyWith(color: Colors.white),
      );
    }).toList();
  }

  Widget _buildLegend() {
    int index = 0;
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: cubit.categoryExpenses.entries.map((entry) {
        final color = chartColors[index % chartColors.length];
        index++;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            horizontalSpace4,
            Text(entry.key, style: TextStylesManager.regular14),
          ],
        );
      }).toList(),
    );
  }
}
