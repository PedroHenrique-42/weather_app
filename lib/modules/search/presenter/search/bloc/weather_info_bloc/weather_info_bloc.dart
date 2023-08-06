import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/domain/usecases/get_weather_info.dart';
import 'package:weather_app/modules/search/presenter/search/bloc/weather_info_bloc/states/weather_info_states.dart';

class WeatherInfoBloc extends Bloc<LatLng, WeatherInfoState> {
  final GetWeatherInfo useCase;

  WeatherInfoBloc(this.useCase) : super(WeatherInfoStart()) {
    on<LatLng>((event, emit) async {
      emit(WeatherInfoLoading());

      final result = await useCase(
        lat: event.latitude.toString(),
        long: event.longitude.toString(),
      );

      emit(result.fold(
        (l) => WeatherInfoError(l),
        (r) => WeatherInfoSucess(r),
      ));
    });
  }
}
