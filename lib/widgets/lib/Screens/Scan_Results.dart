import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Scan_Result_widgets.dart';

class ScanResults extends StatelessWidget {
  const ScanResults({super.key});
  static String id = 'Scan Results';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPraimaryColor,
        surfaceTintColor: kPraimaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Scan Results',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: ScanResultWidgets(),
    );
  }
}
