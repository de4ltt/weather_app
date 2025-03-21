import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/locations/location.dart';

import '../../../../domain/bloc/search/locations_bloc.dart';
import 'location_suggestion.dart';

class LocationSuggestionList extends StatelessWidget {
  const LocationSuggestionList({super.key, required this.locations});

  final List<Location> locations;

  @override
  Widget build(BuildContext context) {
    final LocationsBloc bloc = BlocProvider.of<LocationsBloc>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder:
              (BuildContext context, int index) => LocationSuggestion(
                onTap: () => bloc.add(SaveLocation(location: locations[index])),
                location: locations[index],
              ),
          separatorBuilder:
              (BuildContext context, int index) => SizedBox(height: 10),
          itemCount: locations.length,
        ),
      ),
    );
  }
}
