import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.width,
    required this.height,
    required this.fontsize,
    required this.borderRadius,
    this.onPressed,
  });
  final String title;
  final Color color;
  final double width;
  final double height;
  final double fontsize;
  final dynamic borderRadius;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        // width: 340,
        // height: 60,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontsize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
