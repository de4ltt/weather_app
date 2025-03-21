import 'package:weather_app/data/model/weather/main_weather_info.dart';

final class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
  );

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}
