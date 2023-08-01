import 'package:weather_app/modules/search/infra/models/weather_data_model.dart';

abstract class SearchDataSource {
  Future<WeatherDataModel?> getWeatherData({
    required String lat,
    required String long,
  });
}
