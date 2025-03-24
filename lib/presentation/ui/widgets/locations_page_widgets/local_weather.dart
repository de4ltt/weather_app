import 'package:flutter/material.dart';
import 'package:weather_app/data/model/locations/location.dart';
import 'package:weather_app/presentation/ui/pages/main_page.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';

class LocalWeather extends StatelessWidget {
  const LocalWeather({
    super.key,
    required this.location,
    this.isMyLocation = false,
  });

  final Location location;
  final bool isMyLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WeatherPage(lon: location.lon.toDouble(), lat: location.lat.toDouble()))
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.lightBlueAccent,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(16),
        height: 150,
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
