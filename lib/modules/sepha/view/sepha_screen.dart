import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';

class SephaScreen extends StatefulWidget {
  const SephaScreen({super.key});

  @override
  State<SephaScreen> createState() => _SephaScreenState();
}

class _SephaScreenState extends State<SephaScreen> {
  List<String> dhikr = const ['سبحان الله', 'الحمد لله', ' الله أكبر'];
  late PageController _pageController;
  int currentIndex = 0;
  int count = 0;
  double Rotat = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.sebhaBg),
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
              Text('سَبِّحِ اسْمَ رَبِّكَ الأعلى ', style: AppText.s36wB),
              InkWell(
                onTap: updateSepha,
                child: Stack(
                  alignment: .center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Image.asset(AppImage.sebhaHead, scale: 4),

                          AnimatedRotation(
                            turns: Rotat,
                            duration: Duration(milliseconds: 300),

                            child: Image.asset(AppImage.sebhaBody),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 130,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 300,
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (value) {
                                currentIndex = value;

                                count = 0;
                                setState(() {});
                              },
                              itemCount: dhikr.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  dhikr[index],
                                  style: AppText.s36wB,
                                  textAlign: .center,
                                );
                              },
                            ),
                          ),
                          Text('$count', style: AppText.s36wB),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSepha() {
    if (count == 33 && currentIndex == 2) {
      count = 0;

      _pageController.jumpTo(0);
    } else if (count == 33) {
      count = 0;

      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Rotat += 1 / 30;
      count++;
    }

    setState(() {});
  }
}
