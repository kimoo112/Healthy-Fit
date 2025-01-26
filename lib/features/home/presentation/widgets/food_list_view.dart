import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';
import 'package:shimmer/shimmer.dart';

class FoodListViewWidget extends StatelessWidget {
  const FoodListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetFoodsLoading) {
          return const FoodListShimmer();
        } else if (state is GetFoodsLoaded) {
          if (state.foodItems.isEmpty) {
            return const Center(child: Text('No food items available.'));
          }
          return ListView.builder(
            itemCount: state.foodItems.length,
            itemBuilder: (context, index) {
              final item = state.foodItems[index];
              return ListTile(
                onTap: () {
                  customNavigate(context, foodDetails, extra: item);
                },
                title: Text(item.name!),
                subtitle: Text('Category: ${item.category}'),
                trailing: Text('${item.calories} kcal'),
              );
            },
          );
        } else if (state is GetFoodsFailure) {
          return Center(
            child: Text('Error: ${state.errMsg}'),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class FoodListShimmer extends StatelessWidget {
  const FoodListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Number of shimmer items
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 14.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: 100.0,
                        height: 14.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
