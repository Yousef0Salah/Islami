import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/hadeth/view/hadeth_screen.dart';
import 'package:islami/modules/quran/view/quran_screen.dart';
import 'package:islami/modules/radio/view/radio_screen.dart';
import 'package:islami/modules/sepha/view/sepha_screen.dart';
import 'package:islami/modules/time/view/time_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;

  final Set<int> initializedPages = {0, 1, 2};

  final List<Widget> screens = const [
    QuranScreen(),
    HadethScreen(),
    SephaScreen(),
    RadioScreen(),
    TimeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      body: IndexedStack(
        index: index,
        children: List.generate(
          screens.length,
          (i) => initializedPages.contains(i)
              ? screens[i]
              : const SizedBox.shrink(),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            initializedPages.add(value);
          });
        },
        iconSize: 27,
        selectedLabelStyle: const TextStyle(color: AppColors.white),
        fixedColor: AppColors.white,
        backgroundColor: AppColors.gold,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildButtonNavigationItem(title: 'Quran', icon: AppImage.icQuran),
          _buildButtonNavigationItem(title: 'Hadeth', icon: AppImage.icHadeth),
          _buildButtonNavigationItem(title: 'Sebha', icon: AppImage.icSebha),
          _buildButtonNavigationItem(title: 'Radio', icon: AppImage.icRadio),
          _buildButtonNavigationItem(title: 'Time', icon: AppImage.icTime),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _buildButtonNavigationItem({
  required String title,
  required String icon,
}) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(icon, width: 24, height: 24),
    label: title,
    activeIcon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(44),
      ),
      child: SvgPicture.asset(
        icon,
        width: 26,
        height: 26,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    ),
  );
}
