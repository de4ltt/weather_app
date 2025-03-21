part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchLocations extends SearchEvent{
  final String query;

  SearchLocations(this.query);
}