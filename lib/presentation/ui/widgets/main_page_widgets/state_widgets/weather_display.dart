import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/weather/weather_bloc.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/containers/daily_forecast_container.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/general_info.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/containers/hourly_forecast_container.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key, required this.weatherState});

  final WeatherRetrieved weatherState;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, WeatherState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              GeneralInfo(todayWeather: weatherState.todayWeather),
              const SizedBox(height: 10),
              HourlyForecastContainer(
                futureHoursWeather: weatherState.futureHoursWeather,
              ),
              const SizedBox(height: 10),
              DailyForecastContainer(
                futureDaysWeather: weatherState.futureDaysWeather,
              ),
            ],
          ),
        );
      },
    );
  }
}
