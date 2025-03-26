import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class FoodListViewWidget extends StatefulWidget {
  const FoodListViewWidget({super.key});

  @override
  State<FoodListViewWidget> createState() => _FoodListViewWidgetState();
}

class _FoodListViewWidgetState extends State<FoodListViewWidget> {
  String searchQuery = '';
  late Box favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites'); // Open the Hive box
  }

  void toggleFavorite(item) {
    if (favoriteBox.containsKey(item.name)) {
      favoriteBox.delete(item.name);
      debugPrint(Hive.box('favorites').length.toString());
    } else {
      favoriteBox.put(item.name, item.toJson());
      debugPrint(Hive.box('favorites').length.toString());
    }
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              labelText: 'Search for a meal',
              labelStyle: CustomTextStyles.poppins400Style12
                  .copyWith(color: AppColors.dark),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10.0.r),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetFoodsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetFoodsLoaded) {
                List filteredFoodItems = state.foodItems
                    .where((item) =>
                        item.name!.toLowerCase().contains(searchQuery))
                    .toList();

                if (filteredFoodItems.isEmpty) {
                  return const Center(child: Text('No food items found.'));
                }

                return ListView.builder(
                  itemCount: filteredFoodItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredFoodItems[index];
                    bool isFavorite = favoriteBox.containsKey(item.name);

                    return ListTile(
                      leading: _buildCategoryImage(item.name),
                      onTap: () {
                        customNavigate(context, foodDetails, extra: item);
                      },
                      title: Text(item.name!),
                      subtitle: Text('Category: ${item.category}'),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? IconlyBold.heart : IconlyLight.heart,
                          color: isFavorite ? AppColors.red : Colors.grey,
                          size: 15.sp,
                        ),
                        onPressed: () => toggleFavorite(item),
                      ),
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
          ),
        ),
      ],
    );
  }
}

class FoodListShimmer extends StatelessWidget {
  const FoodListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
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

Widget _buildCategoryImage(String? foodName) {
  String? imagePath;
  // String lowerCaseFoodName = foodName!.toLowerCase();

  switch (foodName) {
    case "100g Chicken Fajita":
      imagePath = Assets.imagesChickenFajita;
      break;
    case "100g Grilled Salmon":
      imagePath = Assets.imagesSalmon;
      break;
    case "100g Beef Steak":
      imagePath = Assets.imagesBeefSteak;
      break;
    case "100g Spaghetti Bolognese":
      imagePath = Assets.imagesSpaghettiBolognese;
      break;
    case "100g Caesar Salad":
      imagePath = Assets.imagesCaesarSalad;
      break;
    case "100g Vegetable Stir Fry":
      imagePath = Assets.imagesVegetableStirFry;
      break;
    case "100g Fried Rice":
      imagePath = Assets.imagesFriedRice;
      break;
    case "100g Grilled Chicken Breast":
      imagePath = Assets.imagesGrilledChickenBreast;
      break;
    case "100g Mashed Potatoes":
      imagePath = Assets.imagesPotatoes;
      break;
    case "100g Lentil Soup":
      imagePath = Assets.imagesLentilSoup;
      break;
    case "100g Chocolate Cake":
      imagePath = Assets.imagesChocolateCake;
      break;
    case "100g Fruit Salad":
      imagePath = Assets.imagesFruitSalad;
      break;
    case "100g Potato Chips":
      imagePath = Assets.imagesPotatoChips;
      break;
    case "100g Popcorn":
      imagePath = Assets.imagesPopcorn;
      break;
    case "100g Pretzels":
      imagePath = Assets.imagesPretzels;
      break;
    case "100g Chocolate Bar":
      imagePath = Assets.imagesChocolateBar;
      break;
    case "100g Trail Mix":
      imagePath = Assets.imagesTrailMix;
      break;
    case "100g Cheese Puffs":
      imagePath = Assets.imagesCheesePuffs;
      break;
    case "100g Granola Bars":
      imagePath = Assets.imagesGranolaBars;
      break;
    case "100g Rice Cakes":
      imagePath = Assets.imagesRiceCakes;
      break;
    case "100g Peanuts":
      imagePath = Assets.imagesPeanuts;
      break;
    case "100g Almonds":
      imagePath = Assets.imagesAlmonds;
      break;
    case "100g Dark Chocolate":
      imagePath = Assets.imagesDarkChocolate;
      break;
    case "100g Crackers":
      imagePath = Assets.imagesCrackers;
      break;
    default:
      return Icon(Icons.food_bank, color: AppColors.primaryColor);
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(8.r),
    child: Image.asset(
      imagePath,
      width: 60.w,
      height: 40.h,
      fit: BoxFit.cover,
    ),
  );
}
