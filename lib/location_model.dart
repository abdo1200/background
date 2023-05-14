class LocationModel {
  final double lat;
  final double lng;

  const LocationModel({required this.lat, required this.lng});

  LocationModel copyWith({double? lat, double? lng}) =>
      LocationModel(lat: lat ?? this.lat, lng: lng ?? this.lng);
}
