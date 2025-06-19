

import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/Sign_in_RegisterPage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  static String id = 'SplashScreen';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // Reduced duration to 2 seconds which is more standard
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Registerpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Added main axis alignment
          children: [
            Image.asset('assets/Images/logo.png', width: 180, height: 180),
            const Text(
              'Tomato Connect',
              style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
