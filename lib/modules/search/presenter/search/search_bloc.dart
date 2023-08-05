import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/modules/search/domain/usecases/search_by_lat_long.dart';
import 'package:weather_app/modules/search/presenter/search/states/state.dart';

class SearchBloc extends Bloc<LatLng, SearchState> {
  final SearchByLatLong useCase;

  SearchBloc(this.useCase) : super(SearchStart()) {
    on<LatLng>((event, emit) async {
      emit(SearchLoading());

      final result = await useCase(
        lat: event.latitude.toString(),
        long: event.longitude.toString(),
      );

      emit(result.fold(
        (l) => SearchError(l),
        (r) => SearchSuccess(r),
      ));
    });
  }
}
