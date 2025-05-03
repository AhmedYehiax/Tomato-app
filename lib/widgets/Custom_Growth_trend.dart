import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Container_Growth_History_line.dart';

class CustomGrowthTrend extends StatelessWidget {
  const CustomGrowthTrend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Growth Trends',
              style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
        ContainerGrowthHistoryLine(),
      ],
    );
  }
}
