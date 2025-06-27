import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Plants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Planet_Information_Container.dart';
import 'package:tomatooo_app/widgets/Plant_Info_Container_Photo.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

class AddNewPlant extends StatefulWidget {
  const AddNewPlant({super.key});
  static String id = 'AddNewPlant';

  @override
  State<AddNewPlant> createState() => _AddNewPlantState();
}

class _AddNewPlantState extends State<AddNewPlant> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  String _imagePath = '';
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> _addPlant() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a tomato variety')),
      );
      return;
    }

    // if (_imagePath.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please add a plant photo')),
    //   );
    //   return;
    // }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://tomato-sigma-five.vercel.app/api/v1/growth/addPlant'),
      );

      // Add text fields - using exact field names from Postman collection
      request.fields['tomatoType'] = _nameController.text;
      // Format date as MM/DD/YYYY to match Postman collection format
      String formattedDate = '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}';
      request.fields['plantingDate'] = formattedDate;

      print('Sending request with fields: ${request.fields}');

      // Add photo if selected - but first try without photo to test
      bool photoAdded = false;
      if (_imagePath.isNotEmpty && File(_imagePath).existsSync()) {
        print('Adding photo: $_imagePath');
        try {
          var photoFile = await http.MultipartFile.fromPath(
            'photo',
            _imagePath,
            contentType: MediaType('image', 'png'), // Specify PNG content type
          );
          request.files.add(photoFile);
          photoAdded = true;
          print('Photo file added successfully as PNG');
        } catch (e) {
          print('Error adding photo file: $e');
          // Continue without photo if there's an error
        }
      } else {
        print('No photo to add or file does not exist');
      }

      print('Sending request with ${request.files.length} files...');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully added plant
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Plant added successfully')),
          );
          
          // Parse the response to get the actual plant data
          final responseData = jsonDecode(responseBody);
          print('Full API Response: $responseData');
          
          // Try different possible response structures
          final plantData = responseData['data'] ?? responseData['plant'] ?? responseData;
          print('Extracted Plant Data: $plantData');
          
          // Create a new plant object to return with the actual ID from API
          final newPlant = Plants(
            Name: _nameController.text,
            id: plantData['_id'] ?? plantData['id'] ?? 'Unknown ID',
            lastUpdate: formattedDate,
            image: plantData['photo'] ?? _imagePath,
            days: 160,
            growthStage: 20,
            growthStageName: 'Plant Set',
          );
          
          print('Created Plant Object: ${newPlant.id}');
          Navigator.pop(context, newPlant);
        }
      } else {
        // Handle error
        if (mounted) {
          String errorMessage = 'Failed to add plant';
          if (response.statusCode == 500) {
            errorMessage = 'Server error: Please try again later';
            if (photoAdded) {
              errorMessage += ' (Try without photo)';
            }
          } else if (responseBody.isNotEmpty && !responseBody.contains('<!DOCTYPE html>')) {
            try {
              final errorData = jsonDecode(responseBody);
              errorMessage = errorData['message'] ?? errorMessage;
            } catch (e) {
              errorMessage = 'Error: ${response.statusCode}';
            }
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    } catch (e) {
      print('Error adding plant: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffDCFCE7),
        surfaceTintColor: const Color(0xffDCFCE7),
        foregroundColor: kPraimryTextColor,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.keyboard_backspace_outlined)),
        title: const Text(
          'Add New Plant',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kPraimryTextColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          PlanetInformationContainer(
            nameController: _nameController,
            onDateSelected: _onDateSelected,
            selectedDate: _selectedDate,
          ),
          const SizedBox(height: 25),
          PlantInfoContainerPhoto(
            onImageSelected: (path) {
              setState(() {
                _imagePath = path;
              });
            },
          ),
          const SizedBox(height: 25),
          CustomButton(
            title: _isLoading ? 'Adding Plant...' : 'Add Plant',
            color: kPraimaryColor,
            width: double.infinity,
            height: 50,
            fontsize: 17,
            borderRadius: BorderRadius.circular(10),
            onPressed: _isLoading ? null : _addPlant,
          ),
        ],
      ),
    );
  }
}
