import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/locations/locations_bloc.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather.dart';

class LocalWeatherList extends StatelessWidget {
  const LocalWeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationsBloc bloc = BlocProvider.of<LocationsBloc>(context);

    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        return switch (state) {
          RetrievedLocations() =>
            state.locations.isEmpty
                ? Text(
                  WeatherAppStrings.noLocations,
                  style: TextStyle(color: Colors.white),
                )
                : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return LocalWeather(
                      isMyLocation: false,
                      location: state.locations[index],
                      onTap:
                          () => bloc.add(
                            SwitchFavouriteLocation(
                              location: state.locations[index],
                            ),
                          ),
                      widgetKey: ValueKey<int>(index),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: state.locations.length,
                ),
          LoadingLocations() => CircularProgressIndicator(
            color: Colors.lightBlueAccent,
          ),
          LocationsError() => Text(
            WeatherAppStrings.retrievalError,
            style: TextStyle(color: Colors.white),
          ),
        };
      },
    );
  }
}
