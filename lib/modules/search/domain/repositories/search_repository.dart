import 'package:dartz/dartz.dart';

import '../entities/weather_data.dart';
import '../errors/errors.dart';

abstract class SearchRepository {
  Future<Either<SearchFailure, WeatherData?>> search({
    required String lat,
    required String long,
  });
}
