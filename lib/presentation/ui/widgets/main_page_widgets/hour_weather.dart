import 'package:flutter/material.dart';

class HourWeather extends StatelessWidget {
  const HourWeather({
    super.key,
    required this.timeOfDay,
    required this.icon,
    required this.degrees,
    required this.isNow,
  });

  final TimeOfDay timeOfDay;
  final String icon;
  final int degrees;
  final bool isNow;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 60.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isNow ? "Now" : "${timeOfDay.hour}:00",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Image.network(
          "https://openweathermap.org/img/wn/$icon@2x.png",
          width: imageSize,
          height: imageSize,
        ),
        Text("$degrees°", style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
