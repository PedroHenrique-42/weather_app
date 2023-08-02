import 'dart:convert';

import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/infra/models/weather_description_model.dart';

class WeatherDataModel extends WeatherData {
  WeatherDataModel({
    required super.dateTime,
    required super.sunrise,
    required super.sunset,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.windSpeed,
    required super.weatherDescriptionList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dateTime,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'weatherDescriptionList': weatherDescriptionList
          .map((x) => WeatherDescriptionModel.fromEntity(x).toMap())
          .toList(),
    };
  }

  factory WeatherDataModel.fromMap(Map<String, dynamic> map) {
    return WeatherDataModel(
      dateTime: map['dt'] as int,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
      temp: map['temp'] as double,
      feelsLike: map['feels_like'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      windSpeed: map['wind_speed'] as double,
      weatherDescriptionList: List<WeatherDescriptionModel>.from(
        (map['weather'] as List<dynamic>).map<WeatherDescriptionModel>(
          (object) {
            return WeatherDescriptionModel.fromMap(
              object as Map<String, dynamic>,
            );
          },
        ),
      ),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory WeatherDataModel.fromJson(String source) =>
      WeatherDataModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
