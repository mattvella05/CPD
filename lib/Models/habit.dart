class Habit {
  final String name;
  final double latitude;
  final double longitude;

  Habit({required this.name, required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Habit copyWith({String? name, double? latitude, double? longitude}) {
    return Habit(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'Habit(name: $name, latitude: $latitude, longitude: $longitude)';
  }
}
