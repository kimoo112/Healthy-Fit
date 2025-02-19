import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterme_credit_card/flutterme_credit_card.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class CardView extends StatefulWidget {
  final String selectedPlan; // Pass the selected plan from the SubscriptionView
  final String planPrice; // Pass the plan price from the SubscriptionView

  const CardView({
    super.key,
    required this.selectedPlan,
    required this.planPrice,
  });

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController number = TextEditingController();
  late TextEditingController validThru = TextEditingController();
  late TextEditingController cvv = TextEditingController();
  late TextEditingController holder = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen to state changes within the form field controllers
    number.addListener(() => setState(() {}));
    validThru.addListener(() => setState(() {}));
    cvv.addListener(() => setState(() {}));
    holder.addListener(() => setState(() {}));
    loadCachedValues();
  }

  void loadCachedValues() async {
    number.text = await CacheHelper.getData(key: 'number') ?? '';
    validThru.text = await CacheHelper.getData(key: 'validThru') ?? '';
    cvv.text = await CacheHelper.getData(key: 'cvv') ?? '';
    holder.text = await CacheHelper.getData(key: 'holder') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrow_left_2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription Details',
                    style: CustomTextStyles.poppinsStyle18Bold.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.softGrey,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                          icon: Icons.star_border_rounded,
                          label: 'Selected Plan',
                          value: widget.selectedPlan,
                          valueColor: AppColors.limeGreen,
                        ),
                        10.verticalSpace,
                        _infoRow(
                          icon: Icons.attach_money_rounded,
                          label: 'Price',
                          value: widget.planPrice,
                          valueColor: AppColors.limeGreen,
                        ),
                        10.verticalSpace,
                        _infoRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Billing Cycle',
                          valueColor: AppColors.limeGreen,
                          value: 'Monthly',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,

            // Credit Card
            FMCreditCard(
width: double.infinity,           gradient: LinearGradient(colors: [
                AppColors.primaryColor,
                AppColors.limeGreen.withOpacity(.9),
              ]),
              title: "${CacheHelper.getData(key: ApiKeys.name)} Card"
                  .toUpperCase(),
              number: number.text,
              numberMaskType: FMMaskType.first6last2,
              cvv: cvv.text,
              cvvMaskType: FMMaskType.full,
              validThru: validThru.text,
              validThruMaskType: FMMaskType.none,
              holder: holder.text,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    FMHolderField(
                      controller: holder,
                      cursorColor: AppColors.primaryColor,
                      decoration: inputDecoration(
                        labelText: "Card Holder",
                        hintText: "John Doe",
                      ),
                    ),
                    const SizedBox(height: 30),
                    FMNumberField(
                      controller: number,
                      cursorColor: AppColors.primaryColor,
                      decoration: inputDecoration(
                        labelText: "Card Number",
                        hintText: "0000 0000 0000 0000",
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FMValidThruField(
                            controller: validThru,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              labelStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              labelText: "Valid Thru",
                              hintText: "****",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: FMCvvField(
                            controller: cvv,
                            cursorColor: AppColors.primaryColor,
                            decoration: inputDecoration(
                              labelText: "CVV",
                              hintText: "***",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Confirm Subscription',
              fontSize: 12.sp,
              textColor: AppColors.white,
              borderRadius: 15,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await CacheHelper.saveData(key: 'number', value: number.text);
                  await CacheHelper.saveData(
                      key: 'validThru', value: validThru.text);
                  await CacheHelper.saveData(key: 'cvv', value: cvv.text);
                  await CacheHelper.saveData(key: 'holder', value: holder.text);
                  if (context.mounted) {
                    customNavigate(context, appNavigation);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      labelStyle: TextStyle(color: AppColors.primaryColor),
      labelText: labelText,
      hintText: hintText,
    );
  }
}

// Function to create a styled row with an icon
Widget _infoRow({
  required IconData icon,
  required String label,
  required String value,
  Color valueColor = Colors.black,
}) {
  return Row(
    children: [
      Icon(icon, color: AppColors.primaryColor, size: 20.sp),
      10.horizontalSpace,
      Text(
        '$label: ',
        style: CustomTextStyles.poppins400Style16.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: CustomTextStyles.poppins400Style16.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
