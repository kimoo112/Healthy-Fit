import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class CustomAddMealForm extends StatefulWidget {
  const CustomAddMealForm({
    super.key,
  });

  @override
  State<CustomAddMealForm> createState() => _CustomAddMealFormState();
}

class _CustomAddMealFormState extends State<CustomAddMealForm> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: context.read<HomeCubit>().meal,
            labelText: 'Meal',
            hintText: 'Ma7shi',
            isHavePrefix: false,
          ),
          20.verticalSpace,
          CustomTextFormField(
            controller: context.read<HomeCubit>().calories,
            labelText: 'Calories',
            hintText: '520',
            keyboardType: TextInputType.number,
            isHavePrefix: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter calories';
              } else if (value.length > 4) {
                return 'Please enter The real calories';
              }
              return null;
            },
          ),
          20.verticalSpace,
          CustomTextFormField(
            controller: context.read<HomeCubit>().category,
            labelText: 'Category',
            hintText: 'Protein',
            isHavePrefix: false,
          ),
          20.verticalSpace,
          BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is AddFoodsSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meal added successfully!')),
                );
              } else if (state is AddFoodsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to add meal.')),
                );
              }
            },
            child: CustomButton(
              width: 150.w,
              text: 'ADD MEAL',
              borderRadius: 12.r,
              color: AppColors.primaryColor,
              textColor: AppColors.white,
              fontSize: 14.sp,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<HomeCubit>().addFood();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
