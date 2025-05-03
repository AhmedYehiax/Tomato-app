import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tomatooo_app/Constants.dart';

class ContainerGrowthHistoryLine extends StatelessWidget {
  const ContainerGrowthHistoryLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Beefsteak Tomato (TOM-001)',
              style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.signal, color: kPraimaryColor, size: 22),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Flowering',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Fruit Set',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Fruit Developmen',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Ripening',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Harvest',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kPraimaryColor),
                    backgroundColor: Color(0xffE5E7EB),
                    minHeight: 10,
                    value: 0.4,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
