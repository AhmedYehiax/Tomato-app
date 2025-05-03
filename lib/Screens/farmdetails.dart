import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Farm_Details_Widgets.dart';

class FarmDetails extends StatelessWidget {
  const FarmDetails({super.key});
  static String id = 'FarmDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xffFEE2E2),
        backgroundColor: const Color(0xffFEE2E2),
        foregroundColor: kPraimryTextTwoColor,
        title: Center(
          child: Text(
            'Farm Details',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextTwoColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Icon(Icons.favorite_border_outlined)],
            ),
          ),
        ],
      ),
      body: FarmDetailsWidgets(),
    );
  }
}
