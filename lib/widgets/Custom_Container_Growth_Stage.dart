import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';

class CustomContainerGrowthStage extends StatelessWidget {
  const CustomContainerGrowthStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        width: double.infinity,
        height: 210,
        decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/Images/download.jpg',
                    width: 100,
                    height: 80,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Beefsteak Tomato ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: kFontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            // 55
                          ),
                          Text(
                            'ID: TOM-001',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.calendar,
                            size: 12,
                            color: Colors.grey,
                          ),
                          Text.rich(
                            TextSpan(
                              text:
                                  'Last updated: '
                                  '2024-03-15',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Growth Stage:',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: kFontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 95),
                          Text(
                            'Flowering',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: kFontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Healthy flowers, good',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'pollination',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 35),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.clock,
                                size: 12,
                                color: kSecondaryColor,
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '45 days to',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    'harvest',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButtonIcon(
                    fontcolor: Colors.black,
                    border: Border.all(width: 0.4),
                    title: 'Update Photo',
                    color: Colors.white,
                    IconData: FontAwesomeIcons.camera,
                    iconColor: Colors.black,
                    width: 160,
                    height: 45,
                    fontsize: 13,
                    iconsize: 13,
                  ),
                  CustomButton(
                    fontsize: 13,
                    title: 'Update Status',
                    color: kPraimaryColor,
                    width: 160,
                    height: 45,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
