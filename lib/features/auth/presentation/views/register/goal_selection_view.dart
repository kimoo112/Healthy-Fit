import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../core/utils/app_colors.dart';

class GoalSelectionView extends StatelessWidget {
  const GoalSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Goal"),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.goals.length,
                  itemBuilder: (context, index) {
                    final goal = cubit.goals[index];
                    final isSelected = cubit.selectedGoal == index;
                    return GestureDetector(
                      onTap: () =>
                          cubit.selectGoal(index), // Save selected index
                      child: Container(
                        margin: EdgeInsets.all(12.sp),
                        width: double.infinity,
                        height: 80.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppColors.limeGreen : Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2,
                              color: AppColors.grey.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Image.asset(goal["icon"], width: 40),
                          title: Text(
                            goal["title"],
                            style: TextStyle(
                              color:
                                  isSelected ? AppColors.white : Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              CustomButton(
                onPressed: cubit.selectedGoal != null
                    ? () {
                        customNavigate(context, signup);
                      }
                    : () {},
                text: 'Next',
                borderRadius: 12,
                color: cubit.selectedGoal == null
                    ? AppColors.primaryColor.withOpacity(.6)
                    : AppColors.primaryColor,
                textColor: AppColors.white,
              )
            ],
          );
        },
      ),
    );
  }
}
