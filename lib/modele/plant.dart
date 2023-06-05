class Plant {
  final int id;
  final String name;
  final double moistureMin;
  final double moistureMax;
  final double tempMinDay;
  final double tempMaxDay;
  final double tempMinNight;
  final double tempMaxNight;
  final String image;
  final bool isCreated;

  Plant({
    required this.id,
    required this.name,
    required this.moistureMin,
    required this.moistureMax,
    required this.tempMinDay,
    required this.tempMaxDay,
    required this.tempMinNight,
    required this.tempMaxNight,
    this.image = "default.png",
    required this.isCreated,
  });

  Plant.defaultPlant()
      : id = 0,
        name = 'Plant par défaut',
        moistureMin = 0.0,
        moistureMax = 1.0,
        tempMinDay = 20.0,
        tempMaxDay = 30.0,
        tempMinNight = 15.0,
        tempMaxNight = 25.0,
        image = "default.png",
        isCreated = true;

  Plant.errorPlant()
      : id = -1,
        name = 'Erreur',
        moistureMin = -1.0,
        moistureMax = -1.0,
        tempMinDay = -1.0,
        tempMaxDay = -1.0,
        tempMinNight = -1.0,
        tempMaxNight = -1.0,
        image = "default.png",
        isCreated = false;

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      moistureMin: json['moisture_min'],
      moistureMax: json['moisture_max'],
      tempMinDay: json['temp_min_day'],
      tempMaxDay: json['temp_max_day'],
      tempMinNight: json['temp_min_night'],
      tempMaxNight: json['temp_max_night'],
      image: json['image'],
      isCreated: json['isCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'moisture_min': moistureMin,
      'moisture_max': moistureMax,
      'temp_min_day': tempMinDay,
      'temp_max_day': tempMaxDay,
      'temp_min_night': tempMinNight,
      'temp_max_night': tempMaxNight,
      'image': image,
      'isCreated': isCreated,
    };
  }
}
