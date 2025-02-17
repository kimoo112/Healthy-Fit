import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/app_colors.dart';
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
    context.read<HomeCubit>().fetchWeeklyNutrition(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetWeeklyNutritionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetWeeklyNutritionSuccess) {
            return _buildChart(
              state.weeklyCalories,
              state.weeklyProtein,
              state.weeklyCarbs,
            );
          } else if (state is GetWeeklyNutritionFailure) {
            debugPrint(state.errMsg);
            return Center(child: Text("Error: ${state.errMsg}"));
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }

  Widget _buildChart(
    List<double> weeklyCalories,
    List<double> weeklyProtein,
    List<double> weeklyCarbs,
  ) {
    final List<ChartData> chartData = _mapNutritionToChartData(
      weeklyCalories,
      weeklyProtein,
      weeklyCarbs,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 60.0.sp, top: 30.sp),
      child: SfCartesianChart(
        title: const ChartTitle(text: "Weekly Nutrition"),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: "Days of the Week"),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: "Amount"),
          minimum: 0,
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.calories,
            name: "Calories",
            color: AppColors.limeGreen,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.protein,
            name: "Protein",
            color: AppColors.red,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.carbs,
            name: "Carbs",
            color: AppColors.orange,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  List<ChartData> _mapNutritionToChartData(
    List<double> weeklyCalories,
    List<double> weeklyProtein,
    List<double> weeklyCarbs,
  ) {
    const daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return List.generate(
      weeklyCalories.length,
      (index) => ChartData(
        day: daysOfWeek[index],
        calories: weeklyCalories[index],
        protein: weeklyProtein[index],
        carbs: weeklyCarbs[index],
      ),
    );
  }
}

class ChartData {
  final String day;
  final double calories;
  final double protein;
  final double carbs;

  ChartData({
    required this.day,
    required this.calories,
    required this.protein,
    required this.carbs,
  });
}