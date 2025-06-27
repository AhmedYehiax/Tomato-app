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


      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        // Debug: Print the response to see the structure
        print('API Response: ${response.body}');
        
        final List<dynamic> plantsData = responseData['plants'] ?? [];
        
        setState(() {
          plants = plantsData.map((plantData) {
            // Map status to growthStage and days
            int growthStage = 20;
            int days = 160;
            String status = plantData['status'] ?? 'Plant Set';
            
            // Map status to appropriate values
            switch (status) {
              case 'Plant Set':
                growthStage = 20;
                days = 160;
                break;
              case 'Flowering':
                growthStage = 40;
                days = 65;
                break;
              case 'Fruit Set':
                growthStage = 60;
                days = 30;
                break;
              case 'Ripening':
                growthStage = 80;
                days = 15;
                break;
              case 'Harvesting':
                growthStage = 100;
                days = 0;
                break;
              default:
                growthStage = 20;
                days = 160;
            }
            
            return Plants(
              Name: plantData['tomatoType'] ?? 'Unknown Type',
              id: plantData['_id'] ?? 'No ID',
              lastUpdate: plantData['plantingDate'] ?? 'No Date',
              image: plantData['photo'] ?? '',
              days: days,
              growthStage: growthStage,
              growthStageName: status,
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

  Future<void> _updatePlantGrowthStage(int index, int stage, String stageName, int daysToHarvest) async {
    final plant = plants[index];
    
    try {
      final response = await http.put(
        Uri.parse('https://tomato-sigma-five.vercel.app/api/v1/growth/updatePlantStatus/${plant.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'growthStage': stage,
          'status': stageName,
          'days': daysToHarvest,
        }),
      );

      if (response.statusCode == 200) {
        // Update local state immediately
        setState(() {
          plants[index].growthStage = stage;
          plants[index].growthStageName = stageName;
          plants[index].days = daysToHarvest;
          plants[index].lastUpdate = DateTime.now().toString().split(' ')[0];
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plant status updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update plant status: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error updating plant status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating plant status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deletePlant(int index) async {
    final plant = plants[index];
    
    try {
      final response = await http.delete(
        Uri.parse('https://tomato-sigma-five.vercel.app/api/v1/growth/deletePlant/${plant.id}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          plants.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plant deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete plant: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error deleting plant: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting plant: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                return Dismissible(
                  key: Key(plants[index].id),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) => _deletePlant(index),
                  child: CustomContainerTomatoFruitTracking(
                    Name: plants[index].Name,
                    id: plants[index].id,
                    lastUpdate: plants[index].lastUpdate,
                    image: plants[index].image,
                    days: plants[index].days,
                    growthStage: plants[index].growthStage,
                    growthStageName: plants[index].growthStageName,
                    onGrowthStageUpdate: (stage, stageName, daysToHarvest) =>
                        _updatePlantGrowthStage(index, stage, stageName, daysToHarvest),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
