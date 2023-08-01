import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByLatLong {
  Future<Either<SearchFailure, WeatherData?>> call({
    required String lat,
    required String long,
  });
}

class SearchByLatLongImpl implements SearchByLatLong {
  final SearchRepository _searchRepository;

  SearchByLatLongImpl(this._searchRepository);

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
