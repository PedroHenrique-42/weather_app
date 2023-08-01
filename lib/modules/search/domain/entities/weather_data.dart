import 'package:weather_app/modules/search/domain/entities/weather_description.dart';

class WeatherData {
  final int dateTime;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final List<WeatherDescription> weatherDescriptionList;

  WeatherData({
    required this.dateTime,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weatherDescriptionList,
  });
}
