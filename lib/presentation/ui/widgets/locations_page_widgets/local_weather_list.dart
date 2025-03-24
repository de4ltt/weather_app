import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/search/locations_bloc.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather.dart';

class LocalWeatherList extends StatefulWidget {
  const LocalWeatherList({super.key});

  @override
  State<LocalWeatherList> createState() => _LocalWeatherListState();
}

class _LocalWeatherListState extends State<LocalWeatherList> {
  @override
  Widget build(BuildContext context) {
    final LocationsBloc bloc = BlocProvider.of<LocationsBloc>(context);

    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        if (state is SavedLocations) {
          return state.locations.isEmpty
              ? Center(
                child: Text(
                  WeatherAppStrings.noLocations,
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.separated(
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
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: state.locations.length,
              );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
