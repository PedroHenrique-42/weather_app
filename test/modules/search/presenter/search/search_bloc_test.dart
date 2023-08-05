import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/errors/errors.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';
import 'package:weather_app/modules/search/presenter/search/search_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/states/states.dart';

import 'search_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SearchByLatLong>(),
  MockSpec<WeatherData>(),
])
void main() {
  final useCase = MockSearchByLatLong();

  blocTest(
    "Should return states in right order",
    setUp: () {
      when(useCase(lat: "12.3", long: "32.1")).thenAnswer(
        (realInvocation) async => Right(MockWeatherData()),
      );
    },
    build: () => SearchBloc(useCase),
    act: (bloc) => bloc.add(const LatLng(12.3, 32.1)),
    expect: () => [
      isA<SearchLoading>(),
      isA<SearchSuccess>(),
    ],
  );

  blocTest(
    "Should return error",
    setUp: () {
      when(useCase(lat: "12.3", long: "32.1")).thenAnswer(
        (realInvocation) async => Left(InvalidTextError()),
      );
    },
    build: () => SearchBloc(useCase),
    act: (bloc) => bloc.add(const LatLng(12.3, 32.1)),
    expect: () => [
      isA<SearchLoading>(),
      isA<SearchError>(),
    ],
  );
}
