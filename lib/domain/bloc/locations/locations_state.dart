part of 'locations_bloc.dart';

@immutable
sealed class LocationsState {}

final class RetrievedLocations extends LocationsState {
  final List<Location> locations;

  RetrievedLocations({required this.locations});
}

final class LoadingLocations extends LocationsState {}

final class LocationsError extends LocationsState {}