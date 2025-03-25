import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/locations/location.dart';

part 'save_remove_locations_event.dart';
part 'save_remove_locations_state.dart';

class SaveRemoveLocationsBloc extends Bloc<SaveRemoveLocationsEvent, SaveRemoveLocationsState> {
  SaveRemoveLocationsBloc() : super(SaveRemoveLocationsInitial()) {
    on<RemoveLocation>(_onRemoveLocation);
  }

  Future<void> _onRemoveLocation(RemoveLocation event, Emitter<SaveRemoveLocationsState> emit) async {

  }
}
