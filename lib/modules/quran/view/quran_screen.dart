import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/constant/models/sura_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/layout/widget/most_recently.dart';
import 'package:islami/modules/sura_details/quran_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<SuraModel> suraSearch = [];
  List<SuraModel> mostRecently = [];
  bool isSearch = false;

  @override
  void initState() {
    
    getSura();
    super.initState();
  }

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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            isSearch = false;
                          } else {
                            isSearch = true;
                          }
                          searchFun(value);
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        cursorColor: AppColors.gold,
                        style: AppText.s16wB.copyWith(color: AppColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.black.withValues(alpha: 0.7),
                          hintText: 'Sura Name',
                          hintStyle: AppText.s16wB.copyWith(
                            color: AppColors.white,
                          ),

                          prefixIcon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              AppImage.icQuran,
                              color: AppColors.gold,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gold),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gold),

                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Most Recently ',
                          style: AppText.s16wB.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (mostRecently.isNotEmpty)
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 8);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: mostRecently.length,
                          itemBuilder: (context, index) {
                            return MostRecently(sura: mostRecently[index]);
                          },
                        ),
                      ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          'Sura ',
                          style: AppText.s16wB.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: isSearch && suraSearch.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: AppColors.gold,
                                    size: 48,
                                  ),
                                  Text('لا يوجد سور', style: AppText.s20wB),
                                ],
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                var sura = !isSearch
                                    ? SuraModel.getAllSura()[index]
                                    : suraSearch[index];
                                return InkWell(
                                  onTap: () {
                                    saveSura(sura);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QuranDetailsScreen(sura: sura),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: .center,
                                        children: [
                                          Image.asset(
                                            AppImage.ayaNumber,
                                            width: 52,
                                          ),
                                          Text(
                                            '${sura.id + 1}',
                                            style: AppText.s14wB,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sura.nameEn,
                                            style: AppText.s20wB,
                                          ),

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
                                return Divider(
                                  height: 16,
                                  endIndent: 30,
                                  indent: 30,
                                );
                              },
                              itemCount: !isSearch
                                  ? SuraModel.getAllSura().length
                                  : suraSearch.length,
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

  void searchFun(String q) {
    suraSearch.clear();
    isSearch = q.isNotEmpty;
    for (var e in SuraModel.getAllSura()) {
      if (e.nameEn.toLowerCase().contains(q.toLowerCase()) ||
          e.nameAr.contains(q)) {
        suraSearch.add(e);
      }
    }
    setState(() {});
  }

  void saveSura(SuraModel sura) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    mostRecently.removeWhere((s) => s.id == sura.id);
    mostRecently.insert(0, sura);
    mostRecently = mostRecently.toSet().toList();
    if (mostRecently.length > 5) {
      mostRecently = mostRecently.sublist(0, 5);
    }
    List<String> suraList = List.generate(mostRecently.length, (int index) {
      return mostRecently[index].id.toString();
    });
    prefs.setStringList('mostRecently', suraList);
    setState(() {});
  }

  void getSura() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> suraList = prefs.getStringList('mostRecently') ?? [];
    List<SuraModel> allSura = SuraModel.getAllSura();
    mostRecently.clear();
    for (String idStr in suraList) {
      int id = int.parse(idStr);
      // ابحث عن السورة بالـ id
      var sura = allSura.firstWhere(
        (s) => s.id == id,
        orElse: () => allSura[0], // قيمة افتراضية
      );
      mostRecently.add(sura);
    }

    setState(() {});
  }
}
