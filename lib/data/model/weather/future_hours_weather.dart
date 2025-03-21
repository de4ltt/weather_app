import 'package:weather_app/data/model/weather/day_weather.dart';

class FutureHoursWeather {
  final List<DayWeather> weather;

  factory FutureHoursWeather.fromJson(Map<String, dynamic> json) =>
      FutureHoursWeather(
        weather:
            json['list']
                .map<DayWeather>(
                  (listEl) => DayWeather.fromJson(listEl),
                )
                .toList(),
      );

  const FutureHoursWeather({required this.weather});
}
