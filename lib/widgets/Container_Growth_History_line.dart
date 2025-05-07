import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';

class ContainerGrowthHistoryLine extends StatelessWidget {
  final String Name;
  final String id;
  final int growthStage;

  const ContainerGrowthHistoryLine({
    super.key,
    required this.Name,
    required this.id,
    required this.growthStage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width for each item
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${Name} (${id})',
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.signal, color: kPraimaryColor, size: 18),
              const SizedBox(width: 15),
              Flexible(
                child: Column(
                  children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStageText('Plant Set'),
                    _buildStageText('Flowering'),
                    _buildStageText('Fruit Set'),
                    _buildStageText('Ripening'),
                    _buildStageText('Harvesting'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPraimaryColor),
                  backgroundColor: const Color(0xffE5E7EB),
                  minHeight: 10,
                  value: growthStage / 100,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                   ),
                  ]
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildStageText(String text) {
    return Transform.rotate(
      angle: -45 * (3.1415926535 / 180), // -45 degrees in radians
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10), // Add some padding
        child: Text(
          text,
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}