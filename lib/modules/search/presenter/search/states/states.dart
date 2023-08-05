import 'package:weather_app/modules/search/domain/entities/weather_data.dart';

import '../../../domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess extends SearchState {
  final WeatherData? weatherData;

  SearchSuccess(this.weatherData);
}

class SearchError extends SearchState {
  final SearchFailure error;

  SearchError(this.error);
}

class SearchLoading extends SearchState {}

class SearchStart extends SearchState {}
