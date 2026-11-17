import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.isActive, required this.title});
  final bool isActive;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: .all(8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.gold
              : AppColors.black.withValues(alpha: 0.7),
          borderRadius: .circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: .bold,
              color: isActive ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
