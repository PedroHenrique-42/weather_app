import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/weather_info_bloc/weather_info_bloc.dart';

import '../bloc/map_bloc/events/map_bloc_events.dart';
import '../bloc/map_bloc/map_bloc.dart';
import '../bloc/map_bloc/states/map_bloc_states.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapBloc _mapBloc = Modular.get<MapBloc>();
  final WeatherInfoBloc _weatherInfoBloc = Modular.get<WeatherInfoBloc>();

  @override
  void dispose() {
    _mapBloc.close();
    _weatherInfoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      bloc: _mapBloc,
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: GoogleMap(
            markers: Set.from(state.markers),
            initialCameraPosition: CameraPosition(
              target: state.centerPosition,
              zoom: 10.0,
            ),
            onTap: (position) {
              _mapBloc.add(AddMarkerEvent(position));
              _weatherInfoBloc.add(position);
            },
          ),
        );
      },
    );
  }
}
