import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/locations_repository.dart';
import 'package:weather_app/domain/bloc/search/locations_bloc.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather_list.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/titled_searchbar.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final LocationsRepository locationsRepository = LocationsRepository(
      dio: dio,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    SearchBloc(locationsRepository: locationsRepository),
          ),
          BlocProvider(create: (context) => LocationsBloc()),
        ],
        child: SafeArea(
          bottom: false,
          child: Column(children: [TitledSearchBar(), LocalWeatherList()]),
        ),
      ),
    );
  }
}
