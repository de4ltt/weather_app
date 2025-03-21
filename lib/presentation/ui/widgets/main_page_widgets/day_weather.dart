import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather/future_days_weather.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({
    super.key,
    required this.dayWeather,
    required this.isToday,
  });

  final FutureDaysWeather dayWeather;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 60.0;

    final String dayOfWeek =
        isToday
            ? WeatherAppStrings.today
            : _toDayOfWeek(dayWeather.dateTime.weekday);
    final String icon = dayWeather.weather.icon;

    return SizedBox(
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dayOfWeek,
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.network(
              "https://openweathermap.org/img/wn/$icon@2x.png",
              width: imageSize,
              height: imageSize,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 30,
              children: [
                Text(
                  "${dayWeather.minTemp}°",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${dayWeather.maxTemp}°",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _toDayOfWeek(int day) {

    assert(day > 0 && day < 8);

    return switch(day) {
      1 => WeatherAppStrings.mon,
      2 => WeatherAppStrings.tue,
      3 => WeatherAppStrings.wed,
      4 => WeatherAppStrings.thu,
      5 => WeatherAppStrings.fri,
      6 => WeatherAppStrings.sat,
      7 => WeatherAppStrings.sun,
      _ => throw(UnimplementedError())
    };
  }
}