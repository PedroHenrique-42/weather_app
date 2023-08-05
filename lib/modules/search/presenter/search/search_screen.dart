import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';

import '../../domain/errors/errors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng _center = const LatLng(-23.57080882420231, -46.62210543245166);

  final Set<Marker> markers = {};
  String currentWeather = "";

  void placeMarker(LatLng latLng) async {
    setState(() {
      markers.clear();
      _center = latLng;
      markers.add(Marker(markerId: const MarkerId(""), position: latLng));
    });
    final useCase = Modular.get<SearchByLatLong>();
    late WeatherData? weatherData;

    dartZ.Either<SearchFailure, WeatherData?> future = await useCase(
      lat: latLng.latitude.toString(),
      long: latLng.longitude.toString(),
    );

    future.fold((l) => null, (r) => weatherData = r);

    setState(() {
      currentWeather = weatherData?.temp.toString() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: GoogleMap(
              onTap: (latLng) => placeMarker(latLng),
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10.0,
              ),
            ),
          ),
          Text(
            currentWeather,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
