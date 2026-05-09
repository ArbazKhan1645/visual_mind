import 'package:flutter/material.dart';
import 'package:visualmind/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text(
          'Settings will be added here soon.',
          style: TextStyle(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
