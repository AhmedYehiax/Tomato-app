import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Container_Growth_History_line.dart';

import '../Models/Plants.dart';

class CustomGrowthTrend extends StatelessWidget {
  CustomGrowthTrend({super.key});
  final List<Plants> plants = [
    Plants(
      Name: 'BeefSteak Tomato',
      id: 'Tom-001',
      lastUpdate: '2024-03-15',
      image: '',
      days: 65,
      growthStage: 40,
      growthStageName: 'Flowering',
    ),
    Plants(
      Name: 'Cherry Tomato',
      id: 'Tom-002',
      lastUpdate: '2024-03-15',
      image: '',
      days: 30,
      growthStage: 60,
      growthStageName: 'Fruit Set',
    ),
    Plants(
      Name: 'Roma Tomato',
      id: 'Tom-003',
      lastUpdate: '2024-03-15',
      image: '',
      days: 160,
      growthStage: 20,
      growthStageName: 'Plant Set',
    ),
  ];

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
        SizedBox(
          height: 700, // Adjust based on your needs
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.separated(
              itemCount: plants.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final plant = plants[index];
                return ContainerGrowthHistoryLine(
                  Name: plant.Name,
                  growthStage: plant.growthStage,
                  id: plant.id,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
