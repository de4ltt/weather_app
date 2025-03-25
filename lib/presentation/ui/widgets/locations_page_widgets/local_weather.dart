import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/locations/location.dart';
import 'package:weather_app/domain/bloc/favourites/favourites_bloc.dart';
import 'package:weather_app/domain/bloc/favourites/favourites_bloc.dart';
import 'package:weather_app/domain/bloc/get_locations/get_locations_bloc.dart';
import 'package:weather_app/domain/bloc/save_remove_locations/save_remove_locations_bloc.dart';
import 'package:weather_app/domain/repository/i_saved_locations_repository.dart';
import 'package:weather_app/presentation/ui/pages/main_page.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';

import '../../../../domain/bloc/locations/locations_bloc.dart';

class LocalWeather extends StatefulWidget {
  const LocalWeather({
    super.key,
    required this.location,
    this.isMyLocation = false,
    required this.onTap,
    required this.widgetKey,
  });

  final ValueKey<int> widgetKey;
  final Location location;
  final bool isMyLocation;
  final VoidCallback onTap;

  @override
  State<LocalWeather> createState() => _LocalWeatherState();
}

class _LocalWeatherState extends State<LocalWeather> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SaveRemoveLocationsBloc bloc =
        BlocProvider.of<SaveRemoveLocationsBloc>(context);

    return BlocProvider(
      create:
          (context) => FavouritesBloc(
            locationsRepository:
                RepositoryProvider.of<ISavedLocationsRepository>(context),
            location: widget.location,
          ),
      child: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          return Dismissible(
            background: Container(color: Colors.red),
            onDismissed:
                (_) => bloc.add(RemoveLocation(location: widget.location)),
            key: widget.widgetKey,
            child: GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => WeatherPage(
                            lon: widget.location.lon.toDouble(),
                            lat: widget.location.lat.toDouble(),
                          ),
                    ),
                  ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.lightBlueAccent,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(16),
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: BlocBuilder<FavouritesBloc, FavouritesState>(
                          builder: (context, state) {
                            return Icon(
                              state is IsFavourite
                                  ? Icons.star
                                  : Icons.star_border,
                              color:
                                  state is IsFavourite
                                      ? Colors.orange
                                      : Colors.white,
                              size: 30,
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child:
                          widget.isMyLocation
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    WeatherAppStrings.myLocation,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    widget.location.name,
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                              : Text(
                                widget.location.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "${widget.location.mainWeatherInfo.temp.toInt()}°",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 45,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.location.weather.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
