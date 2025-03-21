import 'package:weather_app/data/model/weather/weather.dart';
import 'main_weather_info.dart';

class TodayWeather {
  final String cityName;
  final Weather weather;
  final MainWeatherInfo mainWeatherInfo;

  factory TodayWeather.fromJson(Map<String, dynamic> json) => TodayWeather(
    mainWeatherInfo: MainWeatherInfo.fromJson(json['main']),
    cityName: json['name'] as String,
    weather: json['weather'].map<Weather>((element) => Weather.fromJson(element)).toList()[0],
  );

  const TodayWeather({
    required this.mainWeatherInfo,
    required this.cityName,
    required this.weather,
  });
}
