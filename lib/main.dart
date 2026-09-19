import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/modules/splash/screens/splash_screen.dart';

void main() {
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
