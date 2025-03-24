import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather/future_days_weather.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/day_weather.dart';

class DailyForecastContainer extends StatelessWidget {
  const DailyForecastContainer({super.key, required this.futureDaysWeather});

  final List<FutureDaysWeather> futureDaysWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return index == 0
              ? Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.calendar_month, color: Colors.white54),
                    Text(
                      "${futureDaysWeather.length}${WeatherAppStrings.forecastDays.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
              : DayWeather(
                dayWeather: futureDaysWeather[index - 1],
                isToday: index == 1,
              );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 2, thickness: 1, color: Colors.white30);
        },
        itemCount: futureDaysWeather.length,
      ),
    );
  }
}
