import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/hadeth_details/screens/hadeth_details_page.dart';

class HadethScreen extends StatefulWidget {
  const HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  List<HadethModel> hadeth = [];

  @override
  void initState() {
    readFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.hadethBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: .bottomCenter,
            colors: [AppColors.black.withValues(alpha: 0.7), AppColors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(AppImage.homeLogo, width: 300),
              const SizedBox(height: 50),

              Expanded(
                child: CarouselSlider.builder(
                  itemCount: hadeth.length,
                  itemBuilder: (context, index, realIndex) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HadethDetailsPage(hadeth: hadeth[index]);
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      AppImage.leftCorner,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        hadeth[index].title,
                                        style: AppText.s24wB,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      AppImage.rightCorner,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: .circular(20),
                                child: Stack(
                                  fit: StackFit.expand,

                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            AppImage.hadithCardBg,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: -10,
                                      right: -10,
                                      child: Image.asset(AppImage.mosque),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        hadeth[index].body,
                                        style: AppText.s16wB,
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    clipBehavior: Clip.none,
                    height: double.infinity,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,

                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    // onPageChanged: (){},
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void readFile() async {
    for (int i = 1; i <= 50; i++) {
      String data = await rootBundle.loadString('assets/Hadeeth/h$i.txt');
      data = data.trim();
      String title = data.split('\n')[0].trim();
      String body = data.split('\n')[1].trim();

      hadeth.add(HadethModel(body: body, title: title));
    }

    setState(() {});
  }
}

class HadethModel {
  String title;
  String body;

  HadethModel({required this.body, required this.title});
}
