import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';

class CarbsAndFatsContainer extends StatelessWidget {
  const CarbsAndFatsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = CacheHelper.getData(key: ApiKeys.id); 
    if (userId == null) {
      return const Center(
          child: Text("User ID is null.")); 
    }
    var box = Hive.box('nutritionBox');
    return ValueListenableBuilder(
      valueListenable: box.listenable(), 
      builder: (context, Box<dynamic> box, _) {
        final currentCarbs = box.get('myCarbs_$userId', defaultValue: 0);
        final currentProtein = box.get('myProtein_$userId', defaultValue: 0);
        debugPrint("Current Carbs: $currentCarbs");
        debugPrint("Current Protein: $currentProtein");
        return Container(
          width: double.infinity,
          height: 80.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.softGrey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Total Carbs
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          '$currentCarbs', // Dynamic carbs value
                          style: CustomTextStyles.poppins400Style18.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' g',
                          style: TextStyle(color: AppColors.orange),
                        ),
                      ],
                    ),
                    const Text('Total Carbs'),
                  ],
                ),

                // Total Protein
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$currentProtein', // Dynamic protein value
                          style: CustomTextStyles.poppins400Style18.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' g',
                          style: TextStyle(color: AppColors.red),
                        ),
                      ],
                    ),
                    const Text('Total Protein'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
