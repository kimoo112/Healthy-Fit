import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late TextEditingController nameController;
  late TextEditingController weightController;

  String userName = '';
  File? _imageFile;
  File? _tempImageFile; // Temporary image before saving
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    weightController = TextEditingController(
      text: CacheHelper.getData(key: ApiKeys.newWeight)?.toString() ??
          CacheHelper.getData(key: ApiKeys.weight).toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    userName = CacheHelper.getData(key: ApiKeys.name) ?? 'Unknown User';
    nameController = TextEditingController(text: userName);
    String? imagePath = CacheHelper.getData(key: 'profile_image');

    if (imagePath != null) {
      final File imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        setState(() {
          _imageFile = imageFile;
        });
      } else {
        debugPrint("Image file does not exist at path: $imagePath");
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _tempImageFile = File(pickedFile.path); // Temporarily store the image
      });
    }
  }

  Future<void> _saveSettings() async {
    String newName = nameController.text.trim();
    String newWeight = weightController.text.trim();

    if (newName.isNotEmpty && newName != userName) {
      await CacheHelper.saveData(key: ApiKeys.name, value: newName);
      setState(() {
        userName = newName;
      });
    }

    if (newWeight.isNotEmpty) {
      int parsedWeight = int.tryParse(newWeight) ?? 0;
      await CacheHelper.saveData(key: ApiKeys.newWeight, value: parsedWeight);
    }

    if (_tempImageFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String uniqueFileName =
          'profile_image_${DateTime.now().millisecondsSinceEpoch}.png';
      final String savedImagePath = '${appDir.path}/$uniqueFileName';

      final File savedImage = await _tempImageFile!.copy(savedImagePath);

      debugPrint("Saved Image Path: $savedImagePath");
      debugPrint("File Exists: ${savedImage.existsSync()}");

      await CacheHelper.saveData(key: 'profile_image', value: savedImagePath);

      setState(() {
        _imageFile = savedImage;
        _tempImageFile = null;
      });
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Profile updated successfully!"),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = CacheHelper.getData(key: ApiKeys.email) ?? 'No email';
    int weight = CacheHelper.getData(key: ApiKeys.weight) ?? 0;
    int height = CacheHelper.getData(key: ApiKeys.height) ?? 0;
    int age = CacheHelper.getData(key: ApiKeys.age) ?? 0;
    int caloriesGoal = CacheHelper.getData(key: ApiKeys.caloriesGoal) ?? 0;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

// Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 80.h),

                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: _tempImageFile != null
                              ? FileImage(_tempImageFile!) // Show temp image
                              : _imageFile != null
                                  ? FileImage(_imageFile!) // Show saved image
                                  : null,
                          child: (_imageFile == null && _tempImageFile == null)
                              ? Icon(IconlyBold.profile,
                                  size: 50, color: AppColors.primaryColor)
                              : null,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              backgroundColor: AppColors.softGrey,
                              radius: 18,
                              child: Icon(Icons.camera_alt,
                                  color: AppColors.primaryColor, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,

                  // User Name
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  20.verticalSpace,

                  _buildInfoCard("Weight", "$weight kg", Icons.monitor_weight),
                  _buildInfoCard("Height", "$height cm", Icons.height),
                  _buildInfoCard("Age", "$age years", Icons.cake),
                  _buildInfoCard("Calorie Goal", "$caloriesGoal kcal",
                      Icons.local_fire_department),

                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 5,
                          offset: Offset(-2, -2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'New Weight (kg)',
                        labelStyle: CustomTextStyles.poppins400Style12Grey
                            .copyWith(fontSize: 11.sp),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.monitor_weight,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(2, 2)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 5,
                            offset: Offset(-2, -2)),
                      ],
                    ),
                    child: TextField(
                      controller: nameController,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Edit Name',
                        labelStyle: CustomTextStyles.poppins400Style12Grey
                            .copyWith(fontSize: 11.sp),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.person, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  CustomButton(
                    onPressed: _saveSettings,
                    text: 'Save Settings',
                    fontSize: 12.sp,
                    textColor: AppColors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(3, 3)),
          BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(-3, -3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 30),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
