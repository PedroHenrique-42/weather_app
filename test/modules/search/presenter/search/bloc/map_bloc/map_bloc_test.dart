import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/events/map_bloc_events.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/map_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/states/map_bloc_states.dart';

void main() {
  blocTest(
    "Should return MapMarkerAdded state",
    build: () => MapBloc(),
    act: (bloc) => bloc.add(AddMarkerEvent(const LatLng(0.0, 0.0))),
    expect: () => [isA<MapMarkerAdded>()],
  );
}
