import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/constant/models/sura_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';

class MostRecently extends StatelessWidget {
  const MostRecently({super.key, required this.sura});

  final SuraModel sura;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 283,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    sura.nameEn,
                    style: AppText.s20wB.copyWith(color: AppColors.black),
                  ),
                  Text(
                    sura.nameAr,
                    style: AppText.s20wB.copyWith(color: AppColors.black),
                  ),
                  Text(
                    sura.ayaNumber,
                    style: AppText.s18wB.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            Image.asset(AppImage.mostRecent),
          ],
        ),
      ),
    );
  }
}
