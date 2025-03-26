import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Box favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites'); // Open Hive box
  }

  void removeFavorite(String key) {
    favoriteBox.delete(key);
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    List favoriteItems = favoriteBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Meals"),
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text("No favorite meals yet."))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: _buildCategoryImage(item['name']), // Load image
                    title: Text(item['name']),
                    subtitle: Text('Category: ${item['category']}'),
                    trailing: IconButton(
                      icon: Icon(IconlyBold.heart, color: AppColors.red),
                      onPressed: () => removeFavorite(item['name']),
                    ),
                    onTap: () {
                      customNavigate(context, foodDetails, extra: item);
                    },
                  ),
                );
              },
            ),
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
