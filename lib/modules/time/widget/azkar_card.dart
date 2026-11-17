
import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';

class AzkarCard extends StatelessWidget {
  const AzkarCard({super.key, required this.title, required this.image, this.onTap});

  final String title;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: .symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gold, width: 2),
            borderRadius: .circular(20),
          ),
          child: Column(
            children: [
              Image.asset(image),
              const SizedBox(height: 8),
              Text(title, style: AppText.s20wB),
            ],
          ),
        ),
      ),
    );
  }
}
