import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class AddMarkerEvent extends MapEvent {
  final LatLng position;

  AddMarkerEvent(this.position);
}