import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/Scan_Track_Tomato.dart';
import 'package:tomatooo_app/Screens/Tomato_MarketPlace.dart';

import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Custom_Container_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'Home Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: ListView(
          children: [
            Column(
              children: [
                const Text(
                  'Welcome To',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: kFontFamily,
                    fontSize: 32,
                    color: Color(0xff166534),
                  ),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Tomato Connect',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: kFontFamily,
                    fontSize: 38,
                    color: Color(0xff166534),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Choose your role to get started',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: kFontFamily,
                    fontWeight: FontWeight.w400,
                    color: kThirdColor,
                  ),
                ),
                const SizedBox(height: 32),
                // Container of Farmer Widget
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainerWidget(
                        iconColor: kPraimaryColor,
                        backgroundColor: const Color(0xffDCFCE7),
                        color: kPraimryTextColor,
                        title: 'I am a Farmer',
                        subtitle:
                            'Diagnose plant diseases, get care guides, and maintain healthy tomato crops',
                        IconData: FontAwesomeIcons.leaf,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ScanTrackTomato.id);
                        },
                        child: CustomButton(
                          fontsize: 16,
                          width: 340,
                          height: 60,
                          title: 'Enter as Farmer',
                          color: kPraimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                // Container of Buyer Widgets
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainerWidget(
                        backgroundColor: const Color(0xffFEE2E2),
                        color: kPraimryTextTwoColor,
                        iconColor: kSecondaryColor,
                        title: 'I am a Buyer',
                        subtitle:
                            'Check tomato quality, browse products, and purchase fresh tomatoes',
                        IconData: FontAwesomeIcons.cartShopping,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, TomatoMarketplace.id);
                        },
                        child: CustomButton(
                          fontsize: 16,
                          width: 340,
                          height: 60,
                          title: 'Enter as buyer',
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
