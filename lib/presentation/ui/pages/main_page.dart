import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/state_widgets/unset_weather.dart';
import '../../../domain/bloc/weather/weather_bloc.dart';
import '../widgets/main_page_widgets/state_widgets/network_error.dart';
import '../widgets/main_page_widgets/state_widgets/weather_display.dart';
import '../widgets/main_page_widgets/state_widgets/weather_loading_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final weatherRepository = WeatherRepository(dio: dio);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        bottom: false,
        child: BlocProvider(
          create:
              (BuildContext context) =>
                  WeatherBloc(weatherRepository: weatherRepository)
                    ..add(UpdateWeatherData()),
          child: Container(
            alignment: Alignment.center,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (BuildContext context, WeatherState state) {
                return switch (state) {
                  WeatherRetrieved() => WeatherDisplay(weatherState: state),
                  WeatherNetworkError() => NetworkError(),
                  WeatherLoading() => WeatherLoadingIndicator(),
                  WeatherUnset() => UnsetWeather(),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
