import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/layout/screens/hadeth_screen.dart';

class HadethDetailsPage extends StatelessWidget {
  const HadethDetailsPage({super.key, required this.hadeth});

  final HadethModel hadeth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        surfaceTintColor: AppColors.black,
        title: Text('Hadeth'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Image.asset(AppImage.leftCorner)),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      hadeth.title,
                      style: AppText.s24wB.copyWith(color: AppColors.gold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(child: Image.asset(AppImage.rightCorner)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text(
                hadeth.body,
                style: AppText.s18wB.copyWith(height: 2),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Spacer(),
          Image.asset(AppImage.mosque),
        ],
      ),
    );
  }
}
