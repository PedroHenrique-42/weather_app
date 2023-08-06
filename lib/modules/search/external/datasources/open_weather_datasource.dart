import 'package:dio/dio.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/infra/datasources/weather_datasource.dart';
import 'package:weather_app/modules/search/infra/models/weather_data_model.dart';

class OpenWeatherDatasource implements WeatherDatasource {
  final Dio dio;

  OpenWeatherDatasource(this.dio);

  @override
  Future<WeatherDataModel?> getWeatherData({
    required String lat,
    required String long,
  }) async {
    String formatedPath = formatOpenWeatherURL(lat, long);
    final response = await dio.get(formatedPath);

    if (response.statusCode == 200) {
      final WeatherDataModel weatherData =
          WeatherDataModel.fromMap(response.data["current"]);
      return weatherData;
    } else {
      throw DatasourceError();
    }
  }

  String formatOpenWeatherURL(String lat, String long) {
    String baseURL =
        "https://api.openweathermap.org/data/3.0/onecall?lang=pt_br&units=metric&lat={lat}&lon={long}&appid=367f9277611c3063a6bc21469f096615";
    late String formattedPath =
        baseURL.replaceFirst("{lat}", lat).replaceFirst("{long}", long);

    return formattedPath;
  }
}
