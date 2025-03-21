import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather_list.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/location_suggestion.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/search_results.dart';

class TitledSearchBar extends StatelessWidget {
  const TitledSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchBloc bloc = BlocProvider.of<SearchBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            WeatherAppStrings.weather,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          SizedBox(height: 7,),
          SearchBar(
            onChanged: (query) => bloc.add(SearchLocations(query)),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(color: Colors.white70, fontSize: 18),
            ),
            shape: const WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            backgroundColor: const WidgetStatePropertyAll<Color>(
              Colors.white12,
            ),
            keyboardType: TextInputType.webSearch,
            hintText: WeatherAppStrings.searchCity,
            hintStyle: const WidgetStatePropertyAll<TextStyle>(
              TextStyle(color: Colors.white38, fontSize: 18),
            ),
            leading: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white38,
            ),
          ),
          SearchResults()
        ],
      ),
    );
  }
}
