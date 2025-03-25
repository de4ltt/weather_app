import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';

import '../../domain/bloc/locations/locations_bloc.dart';
import '../../domain/bloc/search_query/search_bloc.dart';
import '../../domain/repository/i_saved_locations_repository.dart';
import '../../domain/repository/i_search_locations_repository.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => SearchBloc(
                locationsRepository:
                    RepositoryProvider.of<ISearchLocationsRepository>(
                      context,
                      listen: false,
                    ),
              ),
        ),
        BlocProvider(
          create:
              (context) => LocationsBloc(
                locationsRepository:
                    RepositoryProvider.of<ISavedLocationsRepository>(
                      context,
                      listen: false,
                    ),
                weatherRepository:
                  RepositoryProvider.of<IWeatherRepository>(
                    context,
                    listen: false
                  )
              )..add(UpdateAllLocationsData()),
        ),
      ],
      child: child,
    );
  }
}
