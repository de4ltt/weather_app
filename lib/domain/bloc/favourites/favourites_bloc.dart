import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/repository/i_saved_locations_repository.dart';

import '../../../data/model/locations/location.dart';

part 'favourites_event.dart';

part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final ISavedLocationsRepository _locationsRepository;

  FavouritesBloc({
    required ISavedLocationsRepository locationsRepository,
    required Location location,
  }) : _locationsRepository = locationsRepository,
       super(
         location.isFavourite
             ? IsFavourite(location: location)
             : IsNotFavourite(location: location),
       ) {
    on<SwitchFavourites>(_onFavouriteEvent);
  }

  Future<void> _onFavouriteEvent(
    SwitchFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(LoadingFavourite());

    final location =
        state is IsFavourite
            ? (state as IsFavourite).location
            : (state as IsNotFavourite).location;

    final result = await _locationsRepository.switchFavouriteLocation(location);

    if (result) {
      emit(
        state is IsFavourite
            ? IsNotFavourite(location: location.switchFavourite)
            : IsFavourite(location: location.switchFavourite),
      );
    }
  }
}
