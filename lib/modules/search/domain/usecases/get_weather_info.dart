import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/repositories/get_weather_info_repository.dart';

abstract class GetWeatherInfo {
  Future<Either<SearchFailure, WeatherData?>> call({
    required String lat,
    required String long,
  });
}

class GetWeatherInfoImpl implements GetWeatherInfo {
  final GetWeatherInfoRepository _searchRepository;

  GetWeatherInfoImpl(this._searchRepository);

  @override
  Future<Either<SearchFailure, WeatherData?>> call({
    required String lat,
    required String long,
  }) async {
    if (lat.isEmpty || long.isEmpty) {
      return Left(InvalidTextError());
    }

    return _searchRepository.search(lat: lat, long: long);
  }
}
