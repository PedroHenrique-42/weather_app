import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/external/datasources/open_weather_datasource.dart';
import 'package:weather_app/modules/search/utils/open_weather_response.dart';

import 'open_weather_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  final dio = MockDio();
  final datasource = OpenWeatherDatasource(dio);

  test("Should return a WeatherDataModel", () {
    when(
      dio.get(any),
    ).thenAnswer(
      (realInvocation) async => Response(
        requestOptions: RequestOptions(),
        data: jsonDecode(openWeatherResponse),
        statusCode: 200,
      ),
    );

    final result = datasource.getWeatherData(lat: "123", long: "321");
    expect(result, completes);
  });

  test("Should return a DataSourceError if status code is not 200", () {
    when(
      dio.get(any),
    ).thenAnswer(
      (realInvocation) async => Response(
        requestOptions: RequestOptions(),
        data: null,
        statusCode: 401,
      ),
    );

    final result = datasource.getWeatherData(lat: "123", long: "321");
    expect(result, throwsA(isA<DatasourceError>()));
  });
}
