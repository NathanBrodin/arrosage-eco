class Plant {
  final int id;
  final String name;
  final double moistureMin;
  final double moistureMax;
  final double tempMinDay;
  final double tempMaxDay;
  final double tempMinNight;
  final double tempMaxNight;

  Plant({
    required this.id,
    required this.name,
    required this.moistureMin,
    required this.moistureMax,
    required this.tempMinDay,
    required this.tempMaxDay,
    required this.tempMinNight,
    required this.tempMaxNight,
  });

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
    );
  }
}
