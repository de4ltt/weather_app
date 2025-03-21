import 'package:weather_app/data/model/weather/main_weather_info.dart';

import '../weather/weather.dart';

class Location {
  final int id;
  final String name;
  final String country;
  final Weather weather;
  final MainWeatherInfo mainWeatherInfo;
  final num lat;
  final num lon;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'] as String,
    country: json['sys']['country'] as String,
    weather:
        json['weather']
            .map<Weather>((element) => Weather.fromJson(element))
            .toList()[0],
    mainWeatherInfo: MainWeatherInfo.fromJson(json['main']).metric,
    lat: json['coord']['lat'] as num,
    lon: json['coord']['lon'] as num,
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
  });
}
