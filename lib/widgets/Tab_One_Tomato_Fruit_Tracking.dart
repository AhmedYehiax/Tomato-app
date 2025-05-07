import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Plants.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:tomatooo_app/widgets/Custom_Container_Tomato_Fruit_Tracking.dart';
import '../Screens/farmer/addnewplant.dart';


class TabOneTomatoFruitTracking extends StatefulWidget {
  const TabOneTomatoFruitTracking({super.key});

  @override
  State<TabOneTomatoFruitTracking> createState() => _TabOneTomatoFruitTrackingState();
}
class _TabOneTomatoFruitTrackingState extends State<TabOneTomatoFruitTracking> {
  List<Plants> plants = [
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

  void _updatePlantGrowthStage(int index, int stage, String stageName, int daysToHarvest) {
    setState(() {
      plants[index].updateGrowthStage(stage, stageName);
      plants[index].days = daysToHarvest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Tomato Plants',
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(context, AddNewPlant.id);
                  if (result != null && result is Plants) {
                    setState(() {
                      plants.add(result);
                    });
                  }
                },
                child: CustomButtonIcon(
                  title: 'Add New Plant',
                  color: kPraimaryColor,
                  IconData: FontAwesomeIcons.plus,
                  iconColor: Colors.white,
                  width: 150,
                  height: 45,
                  fontsize: 15,
                  iconsize: 15,
                  border: Border.all(width: 0.001),
                  fontcolor: Colors.white,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              return CustomContainerTomatoFruitTracking(
                Name: plants[index].Name,
                id: plants[index].id,
                lastUpdate: plants[index].lastUpdate,
                image: plants[index].image,
                days: plants[index].days,
                growthStage: plants[index].growthStage,
                growthStageName: plants[index].growthStageName,
                onGrowthStageUpdate: (stage, stageName, daysToHarvest) =>
                    _updatePlantGrowthStage(index, stage, stageName, daysToHarvest),
              );
            },
          ),
        ],
      ),
    );
  }
}
