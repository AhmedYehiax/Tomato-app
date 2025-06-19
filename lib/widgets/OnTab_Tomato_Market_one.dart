import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Farms_Models.dart';
import 'package:tomatooo_app/Models/Farm_Favorite_Manager.dart';
import 'package:tomatooo_app/widgets/Container_OnTab_Tomato_MarketPlace.dart';

class OntabTomatoMarketOne extends StatefulWidget {
  const OntabTomatoMarketOne({super.key});

  @override
  State<OntabTomatoMarketOne> createState() => _OntabTomatoMarketOneState();
}

class _OntabTomatoMarketOneState extends State<OntabTomatoMarketOne> {
  List<Farms> farms = [
    Farms(
      name: 'Sunshine Farms',
      location: 'California',
      discription:
          'Family-owned farm practicing organic methods since 1985. Specializes in heirloom tomato varieties.',
      image: 'assets/Images/Farms/farm1.png',
      rating: 4.8,
      isFavorite: false,
    ),
    Farms(
      name: 'Green Valley Farms',
      location: 'Oregon',
      discription:
          'Sustainable farming practices with a focus on organic tomatoes and seasonal produce.',
      image: 'assets/Images/Farms/farm2.png',
      rating: 4.6,
      isFavorite: false,
    ),
    Farms(
      name: 'Red Barn Farms',
      location: 'Washington',
      discription:
          'Specializing in heirloom and hybrid tomato varieties, grown with care and expertise.',
      image: 'assets/Images/Farms/farm3.jpg',
      rating: 4.9,
      isFavorite: false,
    ),
  ];

  void toggleFavorite(int index) {
    setState(() {
      final farm = farms[index];
      farm.isFavorite = !farm.isFavorite;

      if (farm.isFavorite) {
        FarmFavoriteManager.addFavorite(farm);
      } else {
        FarmFavoriteManager.removeFavorite(farm);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: farms.length,
        itemBuilder: (context, index) {
          return ContainerOntabTomatoMarketplace(
            isFavorite: farms[index].isFavorite,
            name: farms[index].name,
            location: farms[index].location,
            discription: farms[index].discription,
            image: farms[index].image,
            rating: farms[index].rating,
            onFavoritePressed: () => toggleFavorite(index),
          );
        },
      ),
    );
  }
}
