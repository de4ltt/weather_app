part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}

final class GetLocations extends LocationsEvent {}

final class SwitchFavouriteLocation extends LocationsEvent {
  final Location location;

  SwitchFavouriteLocation({required this.location});
}

final class SaveLocation extends LocationsEvent {
  final Location location;

  SaveLocation({required this.location});
}

final class RemoveLocation extends LocationsEvent {
  final Location location;

  RemoveLocation({required this.location});
}

final class UpdateAllLocationsData extends LocationsEvent {}
