part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class NoSearchQuery extends SearchState {}

final class SearchingLocations extends SearchState {}

final class LocationsFound extends SearchState {
  final List<Location> locations;

  LocationsFound({required this.locations});
}

final class MinSymbols extends SearchState {}

final class NetworkError extends SearchState {}