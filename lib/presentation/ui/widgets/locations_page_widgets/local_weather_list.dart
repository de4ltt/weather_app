import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/weather/main_weather_info.dart';
import 'package:weather_app/data/model/weather/weather.dart';
import 'package:weather_app/domain/bloc/search/locations_bloc.dart';
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
                  "No locations",
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return LocalWeather(
                    onDismissed:
                        () => setState(() {
                          () => bloc.add(
                            RemoveLocation(location: state.locations[index]),
                          );
                        }),

                    isMyLocation: false,
                    location: state.locations[index],
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
