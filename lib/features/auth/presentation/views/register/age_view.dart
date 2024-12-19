import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/top_right_vectors.dart';

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  State<AgeView> createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  DateTime? _selectedDate; // Selected birth date
  int _calculatedAge = 0; // Calculated age

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Primary color for header, buttons, etc.
            primaryColor: AppColors.primaryColor,
            colorScheme: ColorScheme.light(
              primary:
                  AppColors.primaryColor, // Header background and button color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Default text color
            ),
            dialogBackgroundColor: Colors.grey[200], // Background color
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now()
          .subtract(const Duration(days: 365 * 18)), // Default: 18 years ago
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _calculatedAge = _calculateAge(pickedDate);
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--; // Adjust if the current date is before the birthday in the year
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TopRightVectors(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                90.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your ", style: CustomTextStyles.poppins500Style18),
                    Text("date of birth",
                        style: CustomTextStyles.poppins500Style18
                            .copyWith(color: AppColors.primaryColor)),
                  ],
                ),
                11.verticalSpace,
                Text(
                  'We will use this data to give you a better diet type for you',
                  style: CustomTextStyles.poppins400Style14
                      .copyWith(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                11.verticalSpace,
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.limeGreen.withOpacity(.3)),
                    child: Text(
                      _calculatedAge == 0 ? "Your Age" : "$_calculatedAge",
                      style: CustomTextStyles.poppins400Style20,
                    )),
                50.verticalSpace,
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.softGrey,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: .4,
                              color: AppColors.grey.withOpacity(.2))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? DateFormat('MMMM / dd / yyyy')
                                  .format(_selectedDate!)
                              : "Pick Your Date of birth",
                        ),
                        Icon(
                          IconlyBroken.calendar,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onPressed: _calculatedAge == 0
                      ? () {}
                      : () {
                          customNavigate(context, weightView);
                        },
                  text: 'Next',
                  borderRadius: 12,
                  color: _calculatedAge == 0
                      ? AppColors.primaryColor.withOpacity(.6)
                      : AppColors.primaryColor,
                  textColor: AppColors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
