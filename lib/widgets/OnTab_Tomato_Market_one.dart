import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Container_OnTab_Tomato_MarketPlace.dart';

class OntabTomatoMarketOne extends StatelessWidget {
  const OntabTomatoMarketOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ContainerOntabTomatoMarketplace();
        },
      ),
    );
  }
}
