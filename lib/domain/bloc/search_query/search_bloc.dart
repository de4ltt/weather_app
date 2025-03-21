import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/domain/repository/i_locations_repository.dart';

import '../../../data/model/locations/location.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static const _minSymbols = 3;
  final ILocationsRepository _locationsRepository;

  SearchBloc({required ILocationsRepository locationsRepository})
    : _locationsRepository = locationsRepository,
      super(NoSearchQuery()) {
    on<SearchLocations>(
      _onSearchLocations,
      transformer: debounce(Duration(milliseconds: 200)),
    );
  }

  Future<void> _onSearchLocations(
    SearchLocations event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(NoSearchQuery());
      return;
    }

    if (event.query.length < _minSymbols) {
      emit(MinSymbols());
      return;
    }

    try {
      final List<Location> locations = await _locationsRepository.getLocations(
        event.query,
      );

      emit(
        locations.isEmpty
            ? NoLocationsFound()
            : LocationsFound(locations: locations),
      );
    } catch (e) {
      print(e);
      emit(NetworkError());
    }
  }

  EventTransformer<SearchEvent> debounce<SearchEvent>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
