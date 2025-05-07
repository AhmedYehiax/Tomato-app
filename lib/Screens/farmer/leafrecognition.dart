import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Leaf_Recognition_Widgets.dart';

class LeafRecognition extends StatelessWidget {
  const LeafRecognition({super.key});
  static String id = 'Leaf Recognition';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPraimaryColor,
        surfaceTintColor: kPraimaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Leaf Recognition',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: LeafRecognitionWidgets(),
    );
  }
}
