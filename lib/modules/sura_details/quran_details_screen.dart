import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/constant/models/sura_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranDetailsScreen extends StatefulWidget {
  const QuranDetailsScreen({super.key, required this.sura});
  final SuraModel sura;

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  List<String> suraList = [];
  bool isSplit = false;
  String savedAya = '';
  ScrollController? controller = ScrollController();
  @override
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
                    controller: controller,
                    child: Padding(
                      padding: .all(8),
                      child: Column(
                        children: [
                          if (widget.sura.id != 0 && widget.sura.id != 8)
                            Text(
                              'بسم الله الرحمن الرحيم',
                              style: AppText.s20wB.copyWith(
                                color: AppColors.gold,
                                height: 3,
                              ),
                            ),
                          Text.rich(
                            textDirection: TextDirection.rtl,
                            style: AppText.s20wB.copyWith(
                              color: AppColors.gold,
                              height: 3,
                            ),
                            TextSpan(
                              children: suraList.map((e) {
                                int index = suraList.indexOf(e);
                                return TextSpan(
                                  text: '$e[${index + 1}]',
                                  style: TextStyle(
                                    backgroundColor: e == savedAya
                                        ? Colors.orange.withValues(alpha: 0.2)
                                        : null,
                                  ),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (e == savedAya) {
                                        _removeSaved();
                                      } else {
                                        saveAya(e);
                                        savedAya = e;
                                        setState(() {});
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                'تم حفظ الاية',
                                                style: AppText.s20wB,
                                              ),
                                            ),
                                            backgroundColor: AppColors.gold,
                                            behavior: SnackBarBehavior.floating,
                                            width: 200,
                                            duration: Duration(
                                              milliseconds: 400,
                                            ),
                                          ),
                                        );
                                      }
                                      // getAya();
                                    },
                                );
                              }).toList(),
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

  void readFile() async {
    String data = await rootBundle.loadString(
      'assets/Suras/${widget.sura.id + 1}.txt',
    );
    data = data.trim();
    suraList = data.split('\n');
    getAya();
    setState(() {});
  }

  void saveAya(String aya) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saveAya', aya);

    prefs.setDouble('ayaWhere', controller!.offset);
  }

  void getAya() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedAya = prefs.getString('saveAya') ?? '';
    double offset = prefs.getDouble('ayaWhere') ?? 0;
    if (savedAya.isNotEmpty && suraList.contains(savedAya)) {
      controller?.animateTo(
        offset,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    }
    setState(() {});
  }

  void _removeSaved() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('saveAya');
    prefs.remove('ayaWhere');
    savedAya = '';
    setState(() {});
  }
}
