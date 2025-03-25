part of 'get_locations_bloc.dart';

@immutable
sealed class GetLocationsState {}

final class RetrievedLocations extends GetLocationsState {
  final List<Location> locations;

  RetrievedLocations({required this.locations});
}

final class LoadingLocations extends GetLocationsState {}

final class LocationsError extends GetLocationsState {}