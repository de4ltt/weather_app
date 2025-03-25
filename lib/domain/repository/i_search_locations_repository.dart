import '../../data/model/locations/location.dart';

abstract interface class ISearchLocationsRepository {

  Future<List<Location>> getLocations(final String query);
}