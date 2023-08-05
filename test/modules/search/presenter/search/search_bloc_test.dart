import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:weather_app/app_module.dart';
import 'package:weather_app/modules/search/domain/entities/weather_data.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';
import 'package:weather_app/modules/search/presenter/search/search_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/states/state.dart';

import 'search_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SearchByLatLong>(),
  MockSpec<WeatherData>(),
])
void main() {
  initModule(AppModule());

  final useCase = MockSearchByLatLong();
  final bloc = SearchBloc(useCase);

  test("Should return states in right order", () async* {
    when(useCase(lat: "123", long: "321"))
        .thenAnswer((_) async => Right(MockWeatherData()));

    bloc.add(const LatLng(123, 321));

    expect(
      bloc,
      emitsInOrder([
        isA<SearchSuccess>(),
        isA<SearchLoading>(),
      ]),
    );
  });
}
