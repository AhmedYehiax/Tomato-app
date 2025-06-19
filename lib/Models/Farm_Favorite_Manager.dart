import 'package:flutter/material.dart';
import 'package:tomatooo_app/Models/Farms_Models.dart';

/// A singleton class to manage favorite farms across the app
class FarmFavoriteManager {
  static final List<Farms> _favoriteFarms = [];

  /// Get the list of favorite farms
  static List<Farms> get favoriteFarms => _favoriteFarms;

  /// Add a farm to favorites
  static void addFavorite(Farms farm) {
    if (!_favoriteFarms.any((element) => element.name == farm.name)) {
      farm.isFavorite = true;
      _favoriteFarms.add(farm);
    }
  }

  /// Remove a farm from favorites
  static void removeFavorite(Farms farm) {
    farm.isFavorite = false;
    _favoriteFarms.removeWhere((element) => element.name == farm.name);
  }

  /// Toggle favorite status of a farm
  static void toggleFavorite(Farms farm) {
    if (farm.isFavorite) {
      removeFavorite(farm);
    } else {
      addFavorite(farm);
    }
  }
}