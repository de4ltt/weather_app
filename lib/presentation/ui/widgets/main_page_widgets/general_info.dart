import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather/today_weather.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key, required this.todayWeather});

  final TodayWeather todayWeather;

  @override
  Widget build(BuildContext context) {
    final String cityName = todayWeather.cityName;
    final int degrees = todayWeather.mainWeatherInfo.temp.toInt();
    final String weatherName = _capitalizeEveryWord(todayWeather.weather.description);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cityName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 35,
              shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
            ),
          ),
          Text(
            "$degrees°",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 100,
              letterSpacing: -8,
              shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
            ),
          ),
          Text(
            weatherName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 25,
              shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
            ),
          ),
        ],
      ),
    );
  }

  String _capitalizeEveryWord(final String string) {
    return string.split(" ")
        .map((el) => el[0].toUpperCase() + el.substring(1))
        .join(" ");
  }
}
