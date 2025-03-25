import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/presentation/ui/util/weather_app_strings.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/search_results.dart';

class TitledSearchBar extends StatefulWidget {
  const TitledSearchBar({super.key});

  @override
  State<TitledSearchBar> createState() => _TitledSearchBarState();
}

class _TitledSearchBarState extends State<TitledSearchBar> {
  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

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
          SizedBox(height: 7),
          SearchAnchor(
            viewShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            viewConstraints: BoxConstraints(minHeight: 10),
            viewOnChanged: (query) {
              searchBloc.add(SearchLocations(query));
            },
            isFullScreen: false,
            shrinkWrap: true,
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                onTap: () => controller.openView(),
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
              );
            },
            suggestionsBuilder: (
              BuildContext context,
              SearchController controller,
            ) {
              return [
                SearchResults(
                  onTap: () {
                    controller.closeView("");
                    searchBloc.add(SearchLocations(""));
                  },
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
