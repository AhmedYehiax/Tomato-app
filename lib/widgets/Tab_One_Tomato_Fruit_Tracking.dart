import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/addnewplant.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:tomatooo_app/widgets/Custom_Container_Tomato_Fruit_Tracking.dart';

class TabOneTomatoFruitTracking extends StatelessWidget {
  const TabOneTomatoFruitTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
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
                  onTap: () {
                    Navigator.pushNamed(context, AddNewPlant.id);
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
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
            CustomContainerTomatoFruitTracking(),
          ],
        ),
      ),
    );
  }
}
