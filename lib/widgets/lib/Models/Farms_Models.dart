class Farms{
  final String name;
  final String location;
  final String discription;
  final String image;
  final double rating;
  bool isFavorite;

  Farms({
    required this.name,
    required this.location,
    required this.discription,
    required this.image,
    required this.rating,
    this.isFavorite = false,
  });

}