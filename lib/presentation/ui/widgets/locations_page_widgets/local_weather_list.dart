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
          RetrievedLocations() => ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                background: Container(color: Colors.red),
                onDismissed:
                    (_) => bloc.add(
                      RemoveLocation(location: state.locations[index]),
                    ),
                key: ValueKey<int>(index),
                child: LocalWeather(
                  isMyLocation: false,
                  location: state.locations[index],
                  onTap:
                      () => bloc.add(
                        SwitchFavouriteLocation(
                          location: state.locations[index],
                        ),
                      ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemCount: state.locations.length,
          ),
          LoadingLocations() => CircularProgressIndicator(),
          LocationsError() => Text(
            WeatherAppStrings.retrievalError,
            style: TextStyle(color: Colors.white),
          ),
        };
      },
    );
  }
}
