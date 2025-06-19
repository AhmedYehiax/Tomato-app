import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Plants.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:tomatooo_app/widgets/Custom_Container_Tomato_Fruit_Tracking.dart';
import '../Screens/farmer/addnewplant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabOneTomatoFruitTracking extends StatefulWidget {
  const TabOneTomatoFruitTracking({super.key});

  @override
  State<TabOneTomatoFruitTracking> createState() => _TabOneTomatoFruitTrackingState();
}

class _TabOneTomatoFruitTrackingState extends State<TabOneTomatoFruitTracking> {
  List<Plants> plants = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://tomato-sigma-five.vercel.app/api/v1/growth/getPlants'),
        headers: {'Content-Type': 'application/json'},
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Parsed Response Data: $responseData');
        
        final List<dynamic> plantsData = responseData['plants'] ?? [];
        print('Plants Data: $plantsData');
        print('Plants Data Length: ${plantsData.length}');
        
        setState(() {
          plants = plantsData.map((plantData) {
            print('Processing Plant: $plantData');
            return Plants(
              Name: plantData['tomatoType'] ?? 'Unknown Type',
              id: plantData['_id'] ?? 'No ID',
              lastUpdate: plantData['plantingDate'] ?? 'No Date',
              image: plantData['photo'] ?? '',
              days: plantData['days'] ?? 160,
              growthStage: plantData['growthStage'] ?? 20,
              growthStageName: plantData['status'] ?? 'Plant Set',
            );
          }).toList();
          
          // Sort plants by creation date (most recent first)
          plants.sort((a, b) {
            try {
              DateTime dateA = DateTime.parse(a.lastUpdate);
              DateTime dateB = DateTime.parse(b.lastUpdate);
              return dateB.compareTo(dateA); // Most recent first
            } catch (e) {
              // If date parsing fails, keep original order
              return 0;
            }
          });
          
          _isLoading = false;
        });
        
        print('Final Plants List Length: ${plants.length}');
      } else {
        setState(() {
          _errorMessage = 'Failed to load plants: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching plants: $e');
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

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
                    // Add the new plant to the beginning of the list
                    setState(() {
                      plants.insert(0, result);
                    });
                    
                    // Refresh the list from API after a short delay to get proper IDs
                    Future.delayed(Duration(milliseconds: 500), () {
                      if (mounted) {
                        _fetchPlants();
                      }
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
          if (_isLoading)
            const SizedBox(height: 200,
              child: Center(
                child: CircularProgressIndicator(color: kPraimaryColor,),
              ),
            )
          else if (_errorMessage != null)
            Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _fetchPlants,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (plants.isEmpty)
            Container(
              height: 200,
              child: const Center(
                child: Text('No plants found'),
              ),
            )
          else
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
