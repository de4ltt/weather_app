import '../../data/model/locations/location.dart';

abstract interface class ILocationsRepository {

  Future<List<Location>> getLocations(final String query);
}