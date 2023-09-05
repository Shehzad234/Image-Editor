import 'package:flutter/material.dart';
import 'package:image_editor/features/landing/screen/landing_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashScreenTimer.moveToHome(context);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/splash.gif"), fit: BoxFit.cover)),
    );
  }
}

class SplashScreenTimer {
  static void moveToHome(context) {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LandingScreen.path, (route) => false);
    });
  }
}
