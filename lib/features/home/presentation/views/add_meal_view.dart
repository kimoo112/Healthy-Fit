import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_add_meal_form.dart';

class AddMealView extends StatelessWidget {
  const AddMealView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Meals'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconlyBold.arrow_left_circle,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is AddFoodsSuccessful) {
              context.read<HomeCubit>().fetchFood(context);
            } else if (state is DeleteFoodSuccessful) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Meal Deleted successfully!')),
              );
              context.read<HomeCubit>().fetchFood(context);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAddMealForm(),
                12.verticalSpace,
                Text(
                  'Added Meals',
                  style: CustomTextStyles.poppins400Style14,
                ),
                12.verticalSpace,
                Expanded(
                  child: context.read<HomeCubit>().myFood.isEmpty
                      ? const Center(child: Text("No Food Items Added Yet"))
                      : ListView.builder(
                          itemCount: context.read<HomeCubit>().myFood.length,
                          itemBuilder: (context, index) {
                            final food =
                                context.watch<HomeCubit>().myFood[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.fastfood,
                                          color: Colors.orange, size: 28),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food.name ?? 'Unknown Meal',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Category: ${food.category}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Calories: ${food.calories} kcal',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(IconlyBroken.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        await context
                                            .read<HomeCubit>()
                                            .deleteAddedFood(food.id!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
