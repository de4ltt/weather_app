import 'package:flutter/material.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/local_weather_list.dart';
import 'package:weather_app/presentation/ui/widgets/locations_page_widgets/titled_searchbar.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(children: [TitledSearchBar(), LocalWeatherList()]),
      ),
    );
  }
}
