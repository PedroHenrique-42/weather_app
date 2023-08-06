import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/events/map_bloc_events.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/states/map_bloc_states.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    LatLng defaultPosition = const LatLng(
      -23.57080882420231,
      -46.62210543245166,
    ),
  }) : super(MapInitial(defaultPosition)) {
    on<AddMarkerEvent>((event, emit) {
      List<Marker> markers = [];

      markers.add(
        Marker(
          markerId: MarkerId(Random().nextInt(100).toString()),
          position: event.position,
        ),
      );

      emit(MapMarkerAdded(markers, event.position));
    });
  }
}
