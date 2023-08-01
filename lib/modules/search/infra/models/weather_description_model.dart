import 'dart:convert';

import 'package:weather_app/modules/search/domain/entities/weather_description.dart';

class WeatherDescriptionModel extends WeatherDescription {
  WeatherDescriptionModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherDescriptionModel.fromMap(Map<String, dynamic> map) {
    return WeatherDescriptionModel(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory WeatherDescriptionModel.fromJson(String source) =>
      WeatherDescriptionModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  static WeatherDescriptionModel fromEntity(WeatherDescription entity) {
    return WeatherDescriptionModel(
      id: entity.id,
      main: entity.main,
      description: entity.description,
      icon: entity.icon,
    );
  }
}
