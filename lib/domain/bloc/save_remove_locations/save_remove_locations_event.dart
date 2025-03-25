part of 'save_remove_locations_bloc.dart';

@immutable
sealed class SaveRemoveLocationsEvent {}

final class RemoveLocation extends SaveRemoveLocationsEvent {
  final Location location;

  RemoveLocation({required this.location});
}

/*final class SaveLocation {
  final Location location;

  SaveLocation({required this.location});
}*/
