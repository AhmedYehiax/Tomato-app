import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Growth_trend.dart';

class TabTwoTomatoFruitTracking extends StatelessWidget {
  const TabTwoTomatoFruitTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Container(
          width: double.infinity,

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.4, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: [CustomGrowthTrend()]),
          ),
        ),
      ),
    );
  }
}
