import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/intro_screen/intro_page_model.dart';
import 'package:islami/modules/layout/screens/layout_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  List<IntroPageModel> listIntro = const [
    IntroPageModel(image: AppImage.introWelcome, title: 'Welcome To Islmi App'),
    IntroPageModel(
      image: AppImage.introIslami,
      title: 'Welcome To Islami',
      subTitle: 'We Are Very Excited To Have You In Our Community',
    ),
    IntroPageModel(
      image: AppImage.introQuran,
      title: 'Reading the Quran',
      subTitle: 'Read, and your Lord is the Most Generous',
    ),
    IntroPageModel(
      image: AppImage.introBearish,
      title: 'Bearish',
      subTitle: 'Praise the name of your Lord, the Most High',
    ),
    IntroPageModel(
      image: AppImage.introRadio,
      title: 'Holy Quran Radio',
      subTitle:
          'You can listen to the Holy Quran Radio through the application for free and easily',
    ),
  ];

  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(AppImage.homeLogo, width: 290),

            Expanded(
              child: PageView.builder(
                controller: _pageViewController,
                onPageChanged: (index) {
                  _currentPageIndex = index;
                  setState(() {});
                },
                itemCount: listIntro.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 38),
                          child: Image.asset(
                            listIntro[index].image,
                            width: 390,
                          ),
                        ),
                        Text(
                          listIntro[index].title,
                          style: AppText.s24wB.copyWith(color: AppColors.gold),
                        ),
                        Spacer(flex: 2),
                        if (listIntro[index].subTitle != null)
                          Text(
                            listIntro[index].subTitle!,
                            style: AppText.s20wB.copyWith(
                              color: AppColors.gold,
                              height: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        Spacer(flex: 1),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _pageViewController.previousPage(
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    _currentPageIndex == 0 ? '' : 'Back',
                    style: AppText.s16wB.copyWith(color: AppColors.gold),
                  ),
                ),
                Row(
                  children: List.generate(listIntro.length, (index) {
                    bool isSelect = _currentPageIndex == index;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: isSelect ? 18 : 7,
                      height: 7,
                      margin: .all(6),
                      decoration: BoxDecoration(
                        color: isSelect ? AppColors.gold : AppColors.gray,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPageIndex == listIntro.length - 1) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LayoutScreen()),
                        (route) => false,
                      );
                    } else {
                      _pageViewController.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPageIndex == listIntro.length - 1
                        ? 'Finish'
                        : 'Next',
                    style: AppText.s16wB.copyWith(color: AppColors.gold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
