import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:weather_app/app_module.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';
import 'package:weather_app/modules/search/utils/open_weather_response.dart';

import 'app_module_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  final dio = MockDio();
  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test("Should retrieve the use case without error", () {
    final useCase = Modular.get<SearchByLatLong>();

    expect(useCase, isA<SearchByLatLong>());
  });

  test("Should return a WeatherData", () async {
    when(
      dio.get(any),
    ).thenAnswer((realInvocation) async {
      return Response(
        requestOptions: RequestOptions(),
        data: jsonDecode(openWeatherResponse),
        statusCode: 200,
      );
    });

    final useCase = Modular.get<SearchByLatLong>();

    final result = await useCase(lat: "123", long: "321");

    expect(result | null, isA<WeatherData>());
  });
}
