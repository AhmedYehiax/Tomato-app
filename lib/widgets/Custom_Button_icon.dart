import 'package:flutter/material.dart';

class CustomButtonIcon extends StatelessWidget {
  CustomButtonIcon(
      {super.key,
      required this.title,
      required this.color,
      required this.IconData,
      required this.iconColor,
      required this.width,
      required this.height,
      required this.fontsize,
      required this.iconsize,
      required this.border,
      required this.fontcolor});
  final String title;
  final Color color;
  final IconData;
  final Color iconColor;
  final double width;
  final double height;
  final double fontsize;
  final double iconsize;
  final BoxBorder border;
  final Color fontcolor;

  @override

  // this Button used with icon in Scan - track page
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: iconsize,
            IconData,
            color: iconColor,
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: TextStyle(
                color: fontcolor,
                fontSize: fontsize,
                fontWeight: FontWeight.w500),
          ),
        ],
      )),
    );
  }
}
