import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import '../Screens/farmer/Scan_Track_Tomato.dart';

class ScanResultWidgets extends StatelessWidget {
  const ScanResultWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: ListView(
        children: [
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Care Instructions',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: kbackgroundColorTwo,
                        child: Icon(
                          FontAwesomeIcons.leaf,
                          size: 18,
                          color: kPraimryTextColor,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Remove affected leaves to prevent spread',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: kbackgroundColorTwo,
                        child: Icon(
                          Icons.water_drop_outlined,
                          size: 18,
                          color: kPraimryTextColor,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Water at the base of the plant to keep leaves dry',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: kbackgroundColorTwo,
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          size: 18,
                          color: kPraimryTextColor,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Ensure proper sunlight and air circulation',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ScanTrackTomato.id);
            },
            child: CustomButton(
              title: 'Back to Home',
              color: kPraimaryColor,
              width: double.infinity,
              height: 55,
              fontsize: 16,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}