import 'package:flutter/material.dart';
import 'package:weather_app/data/model/locations/location.dart';
import 'package:weather_app/data/model/weather/main_weather_info.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';

import '../../../../data/model/weather/weather.dart';

class LocalWeather extends StatelessWidget {
  const LocalWeather({
    super.key,
    required this.location,
    this.isMyLocation = false,
    required this.onDismissed,
  });

  final Location location;
  final bool isMyLocation;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.lightBlueAccent,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      height: 150,
      child: Dismissible(
        onDismissed: (_) => onDismissed,
        background: Container(color: Colors.red,),
        key: ValueKey(location.id),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:
                  isMyLocation
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            WeatherAppStrings.myLocation,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            location.name,
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                      : Text(
                        location.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "${location.mainWeatherInfo.temp.toInt()}°",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 45,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                location.weather.description,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
