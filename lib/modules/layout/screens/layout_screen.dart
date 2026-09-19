import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/layout/screens/hadeth_screen.dart';
import 'package:islami/modules/layout/screens/quran_screen.dart';
import 'package:islami/modules/layout/screens/radio_screen.dart';
import 'package:islami/modules/layout/screens/sepha_screen.dart';
import 'package:islami/modules/layout/screens/time_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final List<Widget> screens = const [
    QuranScreen(),
    HadethScreen(),
    SephaScreen(),
    RadioScreen(),
    TimeScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      backgroundColor: AppColors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        iconSize: 27,
        selectedLabelStyle: TextStyle(color: AppColors.white),
        fixedColor: AppColors.white,
        backgroundColor: AppColors.gold,
        type: BottomNavigationBarType.fixed,

        items: [
          _buildButtonNavigationItem(title: 'Quran', icon: AppImage.icHadeth),
          _buildButtonNavigationItem(title: 'Hadeth', icon: AppImage.icQuran),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(44),
      ),
      child: SvgPicture.asset(
        icon,
        width: 26,
        height: 26,
        colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    ),
  );
}
