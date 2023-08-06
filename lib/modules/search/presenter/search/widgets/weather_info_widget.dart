import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/utils/extensions/string_extensions.dart';

import '../bloc/weather_info_bloc/states/weather_info_states.dart';
import '../bloc/weather_info_bloc/weather_info_bloc.dart';

class WeatherInfoWidget extends StatefulWidget {
  const WeatherInfoWidget({super.key});

  @override
  State<WeatherInfoWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget> {
  final WeatherInfoBloc _searchBloc = Modular.get<WeatherInfoBloc>();

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherInfoBloc, WeatherInfoState>(
      bloc: _searchBloc,
      builder: (context, state) {
        if (state is WeatherInfoLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        if (state is WeatherInfoError) {
          return const Expanded(
            child: Center(
              child: Text(
                "Ocorreu um erro inesperado",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        if (state is WeatherInfoSucess) {
          String? icon = state.weatherData?.weatherDescriptionList[0].icon;
          String? description = state
              .weatherData?.weatherDescriptionList[0].description
              .capitalize();
          String? temperature =
              state.weatherData?.temp.toString().replaceDotForComma();
          String? feelsLike =
              state.weatherData?.feelsLike.toString().replaceDotForComma();
          int? humidity = state.weatherData?.humidity;
          String? windSpeed =
              state.weatherData?.windSpeed.toString().replaceDotForComma();

          return Expanded(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.white60,
                      Colors.white10,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.white30),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://openweathermap.org/img/wn/$icon.png",
                    ),
                    Text("$description"),
                    Text("Temperatura: $temperature°"),
                    Text("Sensação: $feelsLike°"),
                    Text("Humidade: $humidity%"),
                    Text("Velocidade do vento: $windSpeed"),
                  ],
                ),
              ),
            ),
          );
        }
        return const Expanded(
          child: Center(
            child: Text(
              "Selecione uma localização no mapa",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
