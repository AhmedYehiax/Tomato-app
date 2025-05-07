import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Plants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Planet_Information_Container.dart';
import 'package:tomatooo_app/widgets/Plant_Info_Container_Photo.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _addPlant() {
    if (_nameController.text.isEmpty || 
        _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newPlant = Plants(
      Name: _nameController.text,
      id: _idController.text,
      lastUpdate: DateTime.now().toString().split(' ')[0],
      image: _imagePath,
    );

    Navigator.pop(context, newPlant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffDCFCE7),
        surfaceTintColor: const Color(0xffDCFCE7),
        foregroundColor: kPraimryTextColor,
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
            idController: _idController,

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
            title: 'Add Plant',
            color: kPraimaryColor,
            width: double.infinity,
            height: 50,
            fontsize: 17,
            borderRadius: BorderRadius.circular(10),
            onPressed: _addPlant,
          ),
        ],
      ),
    );
  }
}
