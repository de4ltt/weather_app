import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/model/locations/location.dart';

import '../../domain/repository/i_saved_locations_repository.dart';

class SavedLocationsRepository implements ISavedLocationsRepository {
  final SharedPreferences _sharedPreferences;

  static const String _locationsListKey = "weather";

  SavedLocationsRepository({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<bool> saveLocation(Location location) async {
    final locationJson = location.toJson();

    final locationsList =
        _sharedPreferences.getStringList(_locationsListKey) ?? <String>[];

    final value = jsonEncode(locationJson);

    locationsList.add(value);

    return _sharedPreferences.setStringList(_locationsListKey, locationsList);
  }

  @override
  Future<List<Location>> getLocations() async {
    final locationsList =
        _sharedPreferences.getStringList(_locationsListKey) ?? <String>[];

    final resultList =
        locationsList
            .map<Location>((element) => Location.fromJson(jsonDecode(element)))
            .toList();

    return resultList;
  }

  @override
  Future<bool> removeLocation(Location location) async {
    final locationJson = location.toJson();

    final currentList =
        _sharedPreferences.getStringList(_locationsListKey) ?? <String>[];

    final value = jsonEncode(locationJson);

    currentList.remove(value);

    return _sharedPreferences.setStringList(_locationsListKey, currentList);
  }

  @override
  Future<bool> switchFavouriteLocation(Location location) async {
    final locationsList =
        _sharedPreferences.getStringList(_locationsListKey) ?? <String>[];

    final decodedLocations =
        locationsList
            .map<Location>((element) => Location.fromJson(jsonDecode(element)))
            .toList();

    decodedLocations[decodedLocations.indexOf(location)] =
        location.switchFavourite;

    final encodedLocations =
        decodedLocations
            .map<String>((element) => jsonEncode(element.toJson()))
            .toList();

    return _sharedPreferences.setStringList(
      _locationsListKey,
      encodedLocations,
    );
  }

  @override
  Future<bool> updateLocations(List<Location> locations) async {
    final locationsEncoded =
        locations.map((element) => jsonEncode(element.toJson())).toList();

    return await _sharedPreferences.setStringList(
      _locationsListKey,
      locationsEncoded,
    );
  }
}
