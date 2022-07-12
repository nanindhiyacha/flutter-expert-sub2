import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_on_air_seriestv.dart';

part 'on_the_air_seriestv_event.dart';
part 'on_the_air_seriestv_state.dart';

class SeriesOnTheAirBloc extends Bloc<SeriesOnTheAirEvent, SeriesOnTheAirState> {
  final GetOnTheAirSeriesTV getOnTheAirTVSeries;

  SeriesOnTheAirBloc(this.getOnTheAirTVSeries) : super((OnTheAirTvseriesEmpty())) {
    on<OnTheAirTvseriesShow>((event, emit) async {
      emit(OnTheAirTvseriesLoading());
      final result = await getOnTheAirTVSeries.execute();
      result.fold(
            (failure) {
          emit(OnTheAirTvseriesError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(OnTheAirTvseriesEmpty());
          } else {
            emit(OnTheAirTvseriesHasData(data));
          }
        },
      );
    });
  }
}