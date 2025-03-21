import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/data/model/weather/day_weather.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/hour_weather.dart';

import '../../../../../data/model/weather/future_hours_weather.dart';

class HourlyForecastContainer extends StatelessWidget {
  const HourlyForecastContainer({super.key, required this.futureHoursWeather});

  final FutureHoursWeather futureHoursWeather;

  @override
  Widget build(BuildContext context) {

    final weather = futureHoursWeather.weather;

    return Container(
      height: 145,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: ListView.separated(
        //shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HourWeather(
            timeOfDay: TimeOfDay.fromDateTime(weather[index].dateTime),
            icon: weather[index].weather.icon,
            degrees: weather[index].mainWeatherInfo.temp.toInt(),
            isNow: index == 0,
          );
        },
        separatorBuilder:
            (BuildContext context, int index) => SizedBox(width: 10),
        itemCount: 10,
      ),
    );
  }
}
