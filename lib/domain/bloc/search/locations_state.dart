part of 'locations_bloc.dart';

@immutable
sealed class LocationsState {}

final class SavedLocations extends LocationsState {
  final List<Location> locations;

  SavedLocations({required this.locations});
}
