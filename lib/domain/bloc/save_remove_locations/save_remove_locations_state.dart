part of 'save_remove_locations_bloc.dart';

@immutable
sealed class SaveRemoveLocationsState {}

final class SaveRemoveLoading extends SaveRemoveLocationsState {}

final class SaveRemoveLocationsInitial extends SaveRemoveLocationsState {}
