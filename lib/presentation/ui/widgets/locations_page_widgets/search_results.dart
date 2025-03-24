import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/search/locations_bloc.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/linear_loading_indicator.dart';
import 'package:weather_app/presentation/ui/widgets/main_page_widgets/state_widgets/loading_indicator.dart';

import '../../util/weather_app_strings.dart';
import 'location_suggestion.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final LocationsBloc bloc = BlocProvider.of<LocationsBloc>(context);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: switch (state) {
            NoSearchQuery() => const Text(WeatherAppStrings.noSearchQuery),
            LocationsFound() =>
              state.locations.isEmpty
                  ? const Text(WeatherAppStrings.noLocationsFound)
                  : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder:
                        (BuildContext context, int index) => LocationSuggestion(
                          onTap: () {
                            bloc.add(
                              SaveLocation(location: state.locations[index]),
                            );
                            onTap();
                          },
                          location: state.locations[index],
                        ),
                    separatorBuilder:
                        (BuildContext context, int index) =>
                            SizedBox(height: 10),
                    itemCount: state.locations.length,
                  ),
            NetworkError() => const Text(
              WeatherAppStrings.networkError,
              style: TextStyle(color: Colors.red),
            ),
            MinSymbols() => const Text(WeatherAppStrings.minSymbols),
            LoadingLocations() => const LinearLoadingIndicator(),
          },
        );
      },
    );
  }
}
