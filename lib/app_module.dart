import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';
import 'package:weather_app/modules/search/external/datasources/open_weather_datasource.dart';
import 'package:weather_app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:weather_app/modules/search/presenter/search/search_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind((i) => OpenWeatherDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind.factory((i) => SearchByLatLongImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SearchScreen()),
      ];
}
