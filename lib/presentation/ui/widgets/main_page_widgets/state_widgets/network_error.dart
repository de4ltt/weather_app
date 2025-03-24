import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/weather/weather_bloc.dart';

import '../../../util/weather_app_strings.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        const Text(
          WeatherAppStrings.networkError,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black12, blurRadius: 10)],
          ),
        ),
        FilledButton(
          onPressed: () => bloc.add(UpdateWeatherData(lat: 0.0, lon: 0.0)),
          child: Text(
            WeatherAppStrings.refresh
          ),
        ),
      ],
    );
  }
}
