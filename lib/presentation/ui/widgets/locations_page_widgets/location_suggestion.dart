import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/search/locations_bloc.dart';

import '../../../../data/model/locations/location.dart';

class LocationSuggestion extends StatelessWidget {
  const LocationSuggestion({
    super.key,
    required this.location,
    required this.onTap,
  });

  final Location location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          spacing: 5,
          children: [
            Icon(Icons.location_city, fill: 1.0, color: Colors.white60),
            Text(
              "${location.name}, ${location.country}",
              style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
