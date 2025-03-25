part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

final class IsNotFavourite extends FavouritesState {
  final Location location;

  IsNotFavourite({required this.location});
}
final class IsFavourite extends FavouritesState {
  final Location location;

  IsFavourite({required this.location});
}
final class LoadingFavourite extends FavouritesState {}