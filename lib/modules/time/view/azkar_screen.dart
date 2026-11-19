import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/time/data/model/azkar_model.dart';
import 'package:islami/modules/time/widget/zekr_card.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key, required this.zekrs});
  final List<Zekr> zekrs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(zekrs[0].category),
        centerTitle: true,
        surfaceTintColor: AppColors.black,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ZekrCard(zekrInfo: zekrs[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
        itemCount: zekrs.length,
      ),
    );
  }
}
