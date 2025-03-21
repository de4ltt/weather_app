import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/locations/location.dart';

part 'locations_event.dart';

part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final List<Location> _locations = List.of([]);

  LocationsBloc() : super(SavedLocations(locations: List.of([]))) {
    on<LocationsEvent>(
      (LocationsEvent event, Emitter<LocationsState> emit) => switch (event) {
        SaveLocation() => _onSaveLocation(event, emit),
        RemoveLocation() => _onRemoveLocation(event, emit),
      },
    );
  }

  void _onSaveLocation(SaveLocation event, Emitter<LocationsState> emit) =>
      emit(
        SavedLocations(
          locations: [
            ...(state as SavedLocations).locations,
            ...[event.location],
          ],
        ),
      );

  void _onRemoveLocation(RemoveLocation event, Emitter<LocationsState> emit) =>
      emit(
        SavedLocations(
          locations:
              (state as SavedLocations).locations
                  .where((element) => element != event.location)
                  .toList(),
        ),
      );
}
