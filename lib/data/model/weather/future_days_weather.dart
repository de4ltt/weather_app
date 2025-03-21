import 'package:weather_app/data/model/weather/weather.dart';

class FutureDaysWeather {
  final int minTemp;
  final int maxTemp;
  final Weather weather;
  final DateTime dateTime;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FutureDaysWeather && dateTime == other.dateTime;
  const FutureDaysWeather({
    required this.minTemp,
    required this.maxTemp,
    required this.weather,
    required this.dateTime
  });
}
