import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/repositories/get_weather_info_repository.dart';
import 'package:weather_app/modules/search/infra/datasources/weather_datasource.dart';

class GetWeatherInfoRepositoryImpl implements GetWeatherInfoRepository {
  final WeatherDatasource datasource;

  GetWeatherInfoRepositoryImpl(this.datasource);

  @override
  Future<Either<SearchFailure, WeatherData?>> search({
    required String lat,
    required String long,
  }) async {
    try {
      final result = await datasource.getWeatherData(lat: lat, long: long);
      return Right(result);
    } on DatasourceError catch (error) {
      return Left(error);
    } catch (error) {
      return Left(DatasourceError());
    }
  }
}
