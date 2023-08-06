import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {
  final LatLng centerPosition;
  final List<Marker> markers;

  MapState({required this.centerPosition, required this.markers});
}

class MapInitial extends MapState {
  MapInitial(LatLng centerPosition)
      : super(centerPosition: centerPosition, markers: []);
}

class MapMarkerAdded extends MapState {
  MapMarkerAdded(List<Marker> markers, LatLng centerPosition)
      : super(centerPosition: centerPosition, markers: markers);
}
