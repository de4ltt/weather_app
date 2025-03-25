import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/repository/i_saved_locations_repository.dart';
import 'package:weather_app/domain/repository/i_weather_repository.dart';

import '../../../data/model/locations/location.dart';

part 'get_locations_event.dart';

part 'get_locations_state.dart';

class GetLocationsBloc extends Bloc<GetLocationsEvent, GetLocationsState> {
  final ISavedLocationsRepository _locationsRepository;
  final IWeatherRepository _weatherRepository;

  GetLocationsBloc({
    required ISavedLocationsRepository locationsRepository,
    required IWeatherRepository weatherRepository,
  }) : _locationsRepository = locationsRepository,
       _weatherRepository = weatherRepository,
       super(RetrievedLocations(locations: [])) {
    on<GetLocationsEvent>(_onUpdateAllLocationsData);
  }

  Future<void> _onUpdateAllLocationsData(
    GetLocationsEvent event,
    Emitter<GetLocationsState> emit,
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

    } catch (e) {
      print(e);
      emit(LocationsError());
    }
  }
}
