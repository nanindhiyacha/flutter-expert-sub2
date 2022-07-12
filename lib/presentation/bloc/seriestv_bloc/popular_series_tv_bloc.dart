import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/get_popular_seriestv.dart';

part 'popular_series_tv_event.dart';
part 'popular_series_tv_state.dart';

class SeriesPopularBloc extends Bloc<SeriesPopularEvent, SeriesPopularState> {
  final GetPopularSeriesTV _getPopularTvSeries;

  SeriesPopularBloc(this._getPopularTvSeries) : super(SeriesPopularEmpty()) {
    on<OnPopularTvSeriesShow>((event, emit) async {
      emit(SeriesPopularLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold(
            (failure) {
          emit(SeriesPopularError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesPopularEmpty());
          } else {
            emit(SeriesPopularHasData(data));
          }
        },
      );
    });
  }
}
