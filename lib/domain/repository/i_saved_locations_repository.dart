import 'package:weather_app/data/model/locations/location.dart';

abstract interface class ISavedLocationsRepository {
  Future<bool> updateLocations(final List<Location> locations);
  Future<List<Location>> getLocations();
  Future<bool> saveLocation(final Location location);
  Future<bool> removeLocation(final Location location);
  Future<bool> switchFavouriteLocation(final Location location);
}