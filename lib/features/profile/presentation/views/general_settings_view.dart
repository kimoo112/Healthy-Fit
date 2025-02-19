import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';

class GeneralSettingsView extends StatefulWidget {
  const GeneralSettingsView({super.key});

  @override
  State<GeneralSettingsView> createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
  bool _isNotificationsEnabled = false;
  String _selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    bool? savedNotification = await CacheHelper.getData(key: "notifications");
    String? savedLanguage = await CacheHelper.getData(key: "language");

    setState(() {
      _isNotificationsEnabled = savedNotification ?? false;
      _selectedLanguage = savedLanguage ?? "English";
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _isNotificationsEnabled = value;
    });
    await CacheHelper.saveData(key: "notifications", value: value);
  }

  Future<void> _changeLanguage(String? newLanguage) async {
    if (newLanguage != null) {
      setState(() {
        _selectedLanguage = newLanguage;
      });
      await CacheHelper.saveData(key: "language", value: newLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSettingsItem(
            icon: IconlyBold.user_2,
            title: "Profile",
            onTap: () {},
          ),
          20.verticalSpace,
          _buildSwitchItem(
            icon: IconlyBold.notification,
            title: "Notifications",
            value: _isNotificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          20.verticalSpace,
          _buildSettingsItem(
            icon: IconlyBold.lock,
            title: "Privacy & Security",
            onTap: () {},
          ),
          20.verticalSpace,
          _buildLanguageDropdown(),
          20.verticalSpace,
          _buildSettingsItem(
            icon: IconlyBold.info_circle,
            title: "Help & Support",
            onTap: () {},
          ),
          20.verticalSpace,
          _buildSettingsItem(
            icon: IconlyBold.logout,
            title: "Logout",
            onTap: () async {
              await CacheHelper.removeSecuredString(key: ApiKeys.token);
              if (context.mounted) {
                customNavigate(context, login);
              }
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: CustomTextStyles.poppins400Style14),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: CustomTextStyles.poppins400Style14),
      trailing: Switch(
        value: value,
        activeTrackColor: AppColors.limeGreen,
        inactiveTrackColor: AppColors.red,
        inactiveThumbColor: AppColors.white,
        onChanged: onChanged,
        activeColor: AppColors.white,
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return ListTile(
      leading: Icon(Icons.language, color: AppColors.primaryColor),
      title: Text("Language", style: CustomTextStyles.poppins400Style14),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        items: const [
          DropdownMenuItem(
            value: "English",
            child: Text("English"),
          ),
        ],
        onChanged: _changeLanguage,
      ),
    );
  }
}
