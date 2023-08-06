import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/modules/search/domain/usecases/get_weather_info.dart';
import 'package:weather_app/modules/search/external/datasources/open_weather_datasource.dart';
import 'package:weather_app/modules/search/infra/repositories/get_weather_info_repository_impl.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/map_bloc/map_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/weather_info_bloc/weather_info_bloc.dart';
import 'package:weather_app/modules/search/presenter/search/get_weather_info_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind((i) => OpenWeatherDatasource(i())),
        Bind((i) => GetWeatherInfoRepositoryImpl(i())),
        Bind((i) => GetWeatherInfoImpl(i())),
        Bind.singleton((i) => WeatherInfoBloc(i())),
        Bind.singleton((i) => MapBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SearchScreen()),
      ];
}
