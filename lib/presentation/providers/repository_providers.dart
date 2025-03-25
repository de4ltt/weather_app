import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/saved_locations_repository.dart';
import '../../data/repository/search_locations_repository.dart';
import '../../data/repository/weather_repository.dart';
import '../../domain/repository/i_saved_locations_repository.dart';
import '../../domain/repository/i_search_locations_repository.dart';
import '../../domain/repository/i_weather_repository.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create:
              (context) =>
                  SavedLocationsRepository(
                        sharedPreferences: Provider.of<SharedPreferences>(
                          context,
                          listen: false
                        ),
                      )
                      as ISavedLocationsRepository,
        ),
        RepositoryProvider(
          create:
              (context) =>
                  SearchLocationsRepository(
                        dio: Provider.of<Dio>(context, listen: false),
                      )
                      as ISearchLocationsRepository,
        ),
        RepositoryProvider(
          create:
              (context) =>
                  WeatherRepository(
                        dio: Provider.of<Dio>(context, listen: false),
                      )
                      as IWeatherRepository,
        ),
      ],
      child: child,
    );
  }
}
