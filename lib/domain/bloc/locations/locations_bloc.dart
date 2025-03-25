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
  final IWeatherRepository _weatherRepository;

  LocationsBloc({
    required ISavedLocationsRepository locationsRepository,
    required IWeatherRepository weatherRepository,
  }) : _locationsRepository = locationsRepository,
       _weatherRepository = weatherRepository,
       super(RetrievedLocations(locations: List.of([]))) {
    on<LocationsEvent>(
      (LocationsEvent event, Emitter<LocationsState> emit) => switch (event) {
        SaveLocation() => _onSaveLocation(event, emit),
        RemoveLocation() => _onRemoveLocation(event, emit),
        GetLocations() => _onGetLocations(event, emit),
        SwitchFavouriteLocation() => _onSwitchFavouriteLocation(event, emit),
        UpdateAllLocationsData() => _onUpdateAllLocationsData(event, emit),
      },
    );
  }

  Future<void> _onUpdateAllLocationsData(
    UpdateAllLocationsData event,
    Emitter<LocationsState> emit,
  ) async {
    emit(LoadingLocations());

    try {
      final locations = await _locationsRepository.getLocations();

      for (final locationIndexed in locations.indexed) {
        final newWeather = await _weatherRepository.getTodayForecast(
          locationIndexed.$2.lat,
          locationIndexed.$2.lon,
        );
        locations[locationIndexed.$1] = locationIndexed.$2.copyWith(
          weather: newWeather.weather,
          mainWeatherInfo: newWeather.mainWeatherInfo,
        );
      }

      await _locationsRepository.updateLocations(locations);

      add(GetLocations());
    } catch (e) {
      print(e);
      emit(LocationsError());
    }

  }

  Future<void> _onGetLocations(
    GetLocations event,
    Emitter<LocationsState> emit,
  ) async {
    try {
      emit(LoadingLocations());

      final locations = await _locationsRepository.getLocations();

      emit(RetrievedLocations(locations: locations));
    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }

  Future<void> _onSwitchFavouriteLocation(
    SwitchFavouriteLocation event,
    Emitter<LocationsState> emit,
  ) async {
    try {
      emit(LoadingLocations());

      final result = await _locationsRepository.switchFavouriteLocation(
        event.location,
      );

      if (result) {
        add(GetLocations());
      }
    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }

  void _onSaveLocation(SaveLocation event, Emitter<LocationsState> emit) async {
    try {
      emit(LoadingLocations());

      final result = await _locationsRepository.saveLocation(event.location);

      if (result) {
        add(GetLocations());
      }
    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }

  Future<void> _onRemoveLocation(
    RemoveLocation event,
    Emitter<LocationsState> emit,
  ) async {
    try {
      emit(LoadingLocations());

      final result = await _locationsRepository.removeLocation(event.location);

      if (result) {
        add(GetLocations());
      }
    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }
}
