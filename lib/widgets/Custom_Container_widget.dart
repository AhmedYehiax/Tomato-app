import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';

class CustomContainerWidget extends StatelessWidget {
  CustomContainerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.IconData,
    required this.color,
    required this.backgroundColor,
    required this.iconColor
  });
  final String title;
  final String subtitle;
  final IconData;
  final Color iconColor;
  final Color backgroundColor;
  final Color color;

  @override
  // This widget used in home Page and Some Pages as a Container ( Scan , Track fruit)
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: backgroundColor,
          child: Icon(size: 30, IconData, color: iconColor),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 24,
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: kFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kThirdColor,
          ),
        ),
        const SizedBox(height: 26),
      ],
    );
  }
}
