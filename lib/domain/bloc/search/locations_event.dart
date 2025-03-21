part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}

final class SaveLocation extends LocationsEvent {
  final Location location;

  SaveLocation({required this.location});
}

final class RemoveLocation extends LocationsEvent {
  final Location location;

  RemoveLocation({required this.location});
}
