import 'package:weather_app/modules/search/domain/entities/weather_data.dart';

import '../../../../domain/errors/errors.dart';

abstract class WeatherInfoState {}

class WeatherInfoSucess extends WeatherInfoState {
  final WeatherData? weatherData;

  WeatherInfoSucess(this.weatherData);
}

class WeatherInfoError extends WeatherInfoState {
  final SearchFailure error;

  WeatherInfoError(this.error);
}

class WeatherInfoLoading extends WeatherInfoState {}

class WeatherInfoStart extends WeatherInfoState {}
