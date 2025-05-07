class Plants {
  final String Name;
  final String id;
  String lastUpdate;
  final String image;
  int days;
  int growthStage;
  String growthStageName;

  Plants({
    required this.Name,
    required this.id,
    required this.lastUpdate,
    required this.image,
    this.days=160,
    this.growthStage=20,
    this.growthStageName = 'Plant Set',
  });
  
  void updateGrowthStage(int newStage, String newStageName) {
    growthStage = newStage;
    growthStageName = newStageName;
    lastUpdate = DateTime.now().toString().split(' ')[0]; // Update with current date
  }
}
