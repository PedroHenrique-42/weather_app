import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/repositories/search_repository.dart';
import 'package:weather_app/modules/search/infra/datasources/search_datasource.dart';
import 'package:weather_app/modules/search/infra/models/weather_data_model.dart';
import 'package:weather_app/modules/search/infra/repositories/search_repository_impl.dart';

import 'search_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchDataSource>()])
@GenerateNiceMocks([MockSpec<WeatherDataModel>()])
void main() {
  final SearchDataSource dataSource = MockSearchDataSource();
  final SearchRepository repository = SearchRepositoryImpl(dataSource);

  test('Should return a WeatherData', () async {
    when(dataSource.getWeatherData(lat: "123", long: "321"))
        .thenAnswer((realInvocation) async => MockWeatherDataModel());

    final result = await repository.search(lat: "123", long: "321");

    expect(result | null, isA<WeatherData>());
  });

  test('Should return a DatasourceError if datasource fail', () async {
    when(dataSource.getWeatherData(lat: "", long: "")).thenThrow(Exception());

    final result = await repository.search(lat: "", long: "");

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
