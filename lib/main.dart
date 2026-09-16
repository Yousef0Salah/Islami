import 'package:flutter/material.dart';
import 'package:islami/modules/splash/screens/splash_screen.dart';

void main() {
  runApp(const Islami
  ());
}

class Islami
 extends StatelessWidget {
  const Islami
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

