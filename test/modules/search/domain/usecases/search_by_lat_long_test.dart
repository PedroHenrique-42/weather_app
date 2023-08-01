import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/repositories/search_repository.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';

import 'search_by_lat_long_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchRepository>()])
@GenerateNiceMocks([MockSpec<WeatherData>()])
void main() {
  final repository = MockSearchRepository();
  final useCase = SearchByLatLongImpl(repository);

  test('Should return a WeatherData', () async {
    when(repository.search(lat: "123", long: "321"))
        .thenAnswer((realInvocation) async => Right(MockWeatherData()));

    final result = await useCase(lat: "123", long: "321");

    expect(result | null, isA<WeatherData>());
  });

  test('Should return a Exception if lat or long is empty', () async {
    when(repository.search(lat: "2", long: ""))
        .thenAnswer((realInvocation) async => Right(MockWeatherData()));

    final result = await useCase(lat: "2", long: "");

    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
