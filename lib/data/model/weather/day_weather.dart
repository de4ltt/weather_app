import 'package:weather_app/data/model/weather/weather.dart';
import 'future_days_weather.dart';
import 'main_weather_info.dart';

class DayWeather {
  final Weather weather;
  final MainWeatherInfo mainWeatherInfo;
  final DateTime dateTime;

  factory DayWeather.fromJson(Map<String, dynamic> json) => DayWeather(
    mainWeatherInfo: MainWeatherInfo.fromJson(json['main']),
    weather:
        json['weather']
                .map<Weather>((element) => Weather.fromJson(element))
                .toList()[0]
            as Weather,
    dateTime: DateTime.parse(json['dt_txt']),
  );


  const DayWeather({
    required this.mainWeatherInfo,
    required this.weather,
    required this.dateTime,
  });
}
