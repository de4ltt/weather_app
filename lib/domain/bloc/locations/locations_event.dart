part of 'locations_bloc.dart';

@immutable
sealed class LocationsEvent {}


final class SwitchFavouriteLocation extends LocationsEvent {
  final Location location;

  SwitchFavouriteLocation({required this.location});
}
