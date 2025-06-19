import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Farm_Favorite_Manager.dart';
import 'package:tomatooo_app/widgets/Container_OnTab_Tomato_MarketPlace.dart';

class OntabTomatoMarketTwo extends StatefulWidget {
  const OntabTomatoMarketTwo({super.key});

  @override
  State<OntabTomatoMarketTwo> createState() => _OntabTomatoMarketTwoState();
}

class _OntabTomatoMarketTwoState extends State<OntabTomatoMarketTwo> {
  @override
  Widget build(BuildContext context) {
    final favoriteList = FarmFavoriteManager.favoriteFarms;

    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      body: favoriteList.isEmpty
          ? Center(
              child: Text(
                'No favorite farms yet',
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                return ContainerOntabTomatoMarketplace(
                  isFavorite: true,
                  name: favoriteList[index].name,
                  location: favoriteList[index].location,
                  discription: favoriteList[index].discription,
                  image: favoriteList[index].image,
                  rating: favoriteList[index].rating,
                  onFavoritePressed: () {
                    setState(() {
                      FarmFavoriteManager.removeFavorite(favoriteList[index]);
                    });
                  },
                );
              },
            ),
    );
  }
}
