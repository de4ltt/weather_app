import 'package:weather_app/data/model/weather/main_weather_info.dart';

import '../weather/weather.dart';

class Location {
  final int id;
  final String name;
  final String country;
  final Weather weather;
  final MainWeatherInfo mainWeatherInfo;
  final double lat;
  final double lon;
  final bool isFavourite;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'] as String,
    country: json['sys']['country'] as String,
    weather:
        json['weather']
            .map<Weather>((element) => Weather.fromJson(element))
            .toList()[0],
    mainWeatherInfo: MainWeatherInfo.fromJson(json['main']).metric,
    lat: json['coord']['lat'].toDouble(),
    lon: json['coord']['lon'].toDouble(),
    isFavourite: json['isFavourite'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sys': {'country': country},
    'weather': [weather.toJson()],
    'main': mainWeatherInfo.kelvin.toJson(),
    'coord': {'lat': lat, 'lon': lon},
    'isFavourite': isFavourite,
  };

  Location get switchFavourite => Location(
    id: id,
    weather: weather,
    mainWeatherInfo: mainWeatherInfo,
    name: name,
    country: country,
    lat: lat,
    lon: lon,
    isFavourite: !isFavourite,
  );

  Location copyWith({
    required Weather weather,
    required MainWeatherInfo mainWeatherInfo,
  }) => Location(
    id: id,
    weather: weather,
    mainWeatherInfo: mainWeatherInfo,
    name: name,
    country: country,
    lat: lat,
    lon: lon,
    isFavourite: isFavourite,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  const Location({
    required this.id,
    required this.weather,
    required this.mainWeatherInfo,
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    required this.isFavourite,
  });
}
