import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/bloc/search_query/search_bloc.dart';
import 'package:weather_app/domain/repository/i_saved_locations_repository.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';

import '../../../data/model/locations/location.dart';

part 'locations_event.dart';

part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final ISavedLocationsRepository _locationsRepository;

  LocationsBloc({
    required ISavedLocationsRepository locationsRepository,
    required IWeatherRepository weatherRepository,
  }) : _locationsRepository = locationsRepository,
       super(RetrievedLocations(locations: List.of([]))) {
    on<LocationsEvent>(
      (LocationsEvent event, Emitter<LocationsState> emit) => switch (event) {
        SwitchFavouriteLocation() => _onSwitchFavouriteLocation(event, emit),
      },
    );
  }

  Future<void> _onSwitchFavouriteLocation(
    SwitchFavouriteLocation event,
    Emitter<LocationsState> emit,
  ) async {
    try {
      final locationsList = (state as RetrievedLocations).locations;

      locationsList[locationsList.indexOf(event.location)] = event.location.switchFavourite;

      emit(LoadingLocations());

      final result = await _locationsRepository.switchFavouriteLocation(
        event.location,
      );

      if (result) {
        emit(RetrievedLocations(locations: locationsList));
      }
    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }
}
