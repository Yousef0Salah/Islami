import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/core/service/notification_service.dart';
import 'package:islami/core/service/prayer_settings_service.dart';
import 'package:islami/modules/splash/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
     WidgetsFlutterBinding.ensureInitialized();

  // 1) هات SharedPreferences مرة واحدة
  final prefs = await SharedPreferences.getInstance();

  // 2) مرّرها للـ services اللي محتاجاها
  PrayerSettingsService.instance.init(prefs);

  // 3) خدمة الإشعارات مالهاش علاقة بـ prefs — ناديها بدون argument
  await NotificationService.instance.init();
  runApp(const Islami());
}

class Islami extends StatelessWidget {
  const Islami({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.cairo().fontFamily),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
