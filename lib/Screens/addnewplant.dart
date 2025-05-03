import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Planet_Information_Container.dart';
import 'package:tomatooo_app/widgets/Plant_Info_Container_Photo.dart';

class AddNewPlant extends StatelessWidget {
  const AddNewPlant({super.key});
  static String id = 'AddNewPlant';

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
          PlanetInformationContainer(),
          SizedBox(height: 25),
          PlantInfoContainerPhoto(),
          SizedBox(height: 25),
          CustomButton(
            title: 'Add Plant',
            color: kPraimaryColor,
            width: double.infinity,
            height: 50,
            fontsize: 17,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
