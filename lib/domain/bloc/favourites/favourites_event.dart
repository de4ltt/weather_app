part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

final class SwitchFavourites extends FavouritesEvent {}