import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/containers/bottom_bar.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/state_widgets/unset_weather.dart';
import '../../../domain/bloc/weather/weather_bloc.dart';
import '../widgets/main_page_widgets/state_widgets/network_error.dart';
import '../widgets/main_page_widgets/state_widgets/weather_display.dart';
import '../widgets/main_page_widgets/state_widgets/loading_indicator.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.lon, required this.lat});

  final double lon;
  final double lat;

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final weatherRepository = WeatherRepository(dio: dio);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        bottom: false,
        child: BlocProvider(
          create:
              (BuildContext context) =>
                  WeatherBloc(weatherRepository: weatherRepository)
                    ..add(UpdateWeatherData(lat: lat, lon: lon)),
          child: Container(
            alignment: Alignment.center,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (BuildContext context, WeatherState state) {
                return switch (state) {
                  WeatherRetrieved() => WeatherDisplay(weatherState: state),
                  WeatherNetworkError() => NetworkError(),
                  WeatherLoading() => LoadingIndicator(),
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
