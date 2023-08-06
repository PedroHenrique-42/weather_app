import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/presenter/search/weather_info_bloc/weather_info_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/weather_info_bloc/states/weather_info_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng _center = const LatLng(-23.57080882420231, -46.62210543245166);
  final Set<Marker> _markers = {};
  final SearchBloc _searchBloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  void placeMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(Random().nextInt(100).toString()),
          position: position,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WeatherApp"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GoogleMap(
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
                onTap: (position) {
                  _center = position;
                  _markers.clear();
                  placeMarker(position);
                  _searchBloc.add(position);
                },
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<SearchBloc, WeatherInfoState>(
              bloc: _searchBloc,
              builder: (context, state) {
                if (state is WeatherInfoLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is WeatherInfoError) {
                  return const Text("Ocorreu um erro inesperado");
                }
                if (state is WeatherInfoSucess) {
                  return Column(
                    children: [
                      Text(
                        "Temperatura: ${state.weatherData?.temp.toString()}",
                      ),
                      Text(
                        "Sensação: ${state.weatherData?.feelsLike}",
                      ),
                      Text(
                        "Humidade: ${state.weatherData?.humidity}",
                      ),
                      Text(
                        "Pressão: ${state.weatherData?.pressure}",
                      ),
                      Text(
                        "Descrição: ${state.weatherData?.weatherDescriptionList}",
                      ),
                    ],
                  );
                }
                return const Text("Selecione uma localização no mapa");
              },
            ),
          ],
        ),
      ),
    );
  }
}
