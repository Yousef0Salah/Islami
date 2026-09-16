import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/constant/models/sura_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';

class QuranDetailsScreen extends StatefulWidget {
  const QuranDetailsScreen({super.key, required this.sura});
  final SuraModel sura;

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  List<String> suraList = [];
  bool isSplit = false;
  @override
  Widget build(BuildContext context) {
    if (suraList.isEmpty) {
      readFile();
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.gold,
        title: Text(widget.sura.nameEn),
        centerTitle: true,
        surfaceTintColor: AppColors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSplit = !isSplit;
              });
            },
            icon: Icon(Icons.change_circle),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Image.asset(AppImage.leftCorner)),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      widget.sura.nameAr,
                      style: AppText.s20wB.copyWith(color: AppColors.gold),
                    ),
                  ),
                ),
                Expanded(child: Image.asset(AppImage.rightCorner)),
              ],
            ),
          ),
          (isSplit)
              ? Expanded(
                  child: ListView.builder(
                    itemCount: suraList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: .all(16),
                        margin: .all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gold),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${suraList[index]}[${index + 1}]',
                          style: AppText.s20wB.copyWith(color: AppColors.gold),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: .all(8),
                      child: Text.rich(
                        textDirection: TextDirection.rtl,
                        style: AppText.s20wB.copyWith(
                          color: AppColors.gold,
                          height: 3,
                        ),
                        TextSpan(
                          children: suraList.map((e) {
                            int index = suraList.indexOf(e);
                            return TextSpan(text: '$e[${index + 1}]');
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void readFile() async {
    String data = await rootBundle.loadString(
      'assets/Suras/${widget.sura.id + 1}.txt',
    );
    data = data.trim();
    suraList = data.split('\n');
    setState(() {});
  }
}
