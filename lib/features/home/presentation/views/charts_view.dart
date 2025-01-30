import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../cubit/home_cubit.dart';

class WeeklyCaloriesChartView extends StatefulWidget {
  const WeeklyCaloriesChartView({super.key});

  @override
  State<WeeklyCaloriesChartView> createState() =>
      _WeeklyCaloriesChartViewState();
}

class _WeeklyCaloriesChartViewState extends State<WeeklyCaloriesChartView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchWeeklyCalories(); // ✅ Fetch data on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetWeeklyCaloriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetWeeklyCaloriesSuccess) {
            // ✅ Use the weeklyCalories from the state
            return _buildChart(state.weeklyCalories.cast<double>());
          } else if (state is GetWeeklyCaloriesFailure) {
            debugPrint(state.errMsg);
            return Center(child: Text("Error: ${state.errMsg}"));
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }

  Widget _buildChart(List<double> weeklyCalories) {
    final List<ChartData> chartData = _mapCaloriesToChartData(weeklyCalories);

    return Padding(
      padding: EdgeInsets.only(bottom:60.0.sp,top:30.sp),
      child: SfCartesianChart(
        title: const ChartTitle(text: "Weekly Calories"),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: "Days of the Week"),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: "Calories"),
          minimum: 0,
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.calories,
            name: "Calories",
            color: Colors.blue,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  List<ChartData> _mapCaloriesToChartData(List<double> weeklyCalories) {
    const daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return List.generate(
      weeklyCalories.length,
      (index) =>
          ChartData(day: daysOfWeek[index], calories: weeklyCalories[index]),
    );
  }
}

class ChartData {
  final String day;
  final double calories;

  ChartData({required this.day, required this.calories});
}