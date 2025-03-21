import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/weather/main_weather_info.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather.dart';

import '../../../../data/model/weather/weather.dart';
import 'location_suggestion.dart';
import 'location_suggestion_list.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return switch (state) {
          NoSearchQuery() => const Text(WeatherAppStrings.noSearchQuery),
          LocationsFound() => LocationSuggestionList(
            locations: state.locations,
          ),
          NoLocationsFound() => const Text(
            WeatherAppStrings.noLocationsFound,
            style: TextStyle(color: Colors.red),
          ),
          NetworkError() => const Text(
            WeatherAppStrings.networkError,
            style: TextStyle(color: Colors.red),
          ),
          MinSymbols() => Text("Enter at least 3 symbols"),
        };
      },
    );
  }
}
