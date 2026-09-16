import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/constant/models/sura_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/sura_details/quran_details_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.quranBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: .bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.7),
                    AppColors.black,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Image.asset(AppImage.homeLogo, width: 300),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          var sura = SuraModel.getAllSura()[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuranDetailsScreen(sura: sura,),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Stack(
                                  alignment: .center,
                                  children: [
                                    Image.asset(AppImage.ayaNumber, width: 52),
                                    Text(
                                      '${sura.id + 1}',
                                      style: AppText.s14wB,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sura.nameEn, style: AppText.s20wB),

                                    Text(
                                      '${sura.ayaNumber} Verses',
                                      style: AppText.s14wB,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(sura.nameAr, style: AppText.s20wB),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 16, endIndent: 30, indent: 30);
                        },
                        itemCount: SuraModel.getAllSura().length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
