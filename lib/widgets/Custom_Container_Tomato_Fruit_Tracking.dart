import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';

class CustomContainerTomatoFruitTracking extends StatelessWidget {
  const CustomContainerTomatoFruitTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/Images/download.jpg',
                    width: 70,
                    height: 70,
                  ),
                  SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Beefsteak Tomato',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Id: TOM-001',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Text(
                              ' Last updated: ',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '2024-03-15',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Growth Stage:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Flowering',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // this for linear Progress
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(kPraimaryColor),
                          backgroundColor: Color(0xffE5E7EB),
                          minHeight: 10,
                          value: 0.4,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Healthy flowers,good ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: kFontFamily,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Pollination',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: kFontFamily,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.clock,
                                  size: 15,
                                  color: Color(0xffF08A54),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  children: [
                                    Text(
                                      '45 days to',
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffF08A54),
                                      ),
                                    ),
                                    Text(
                                      'harvest',
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffF08A54),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButtonIcon(
                        title: 'Update Photo',
                        color: Colors.white,
                        IconData: Icons.camera_alt_outlined,
                        iconColor: Colors.black,
                        width: MediaQuery.of(context).size.height,
                        height: 45,
                        fontsize: 14.2,
                        iconsize: 17,
                        border: Border.all(width: 0.4, color: Colors.grey),
                        fontcolor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        title: 'Update Status',
                        color: kPraimaryColor,
                        width: MediaQuery.of(context).size.height,
                        height: 45,
                        fontsize: 14.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
