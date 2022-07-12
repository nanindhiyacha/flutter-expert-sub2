import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_seriestv.dart';
import 'package:equatable/equatable.dart';


part 'top_rated_series_tv_event.dart';
part 'top_rated_series_tv_state.dart';

class SeriesTopRatedBloc
    extends Bloc<SeriesTopRatedEvent, SeriesTopRatedState> {
  final GetTopRatedSeriesTV getTopRatedTVSeries;

  SeriesTopRatedBloc(this.getTopRatedTVSeries) : super(SeriesTopRatedEmpty()) {
    on<OnSeriesTopRatedShow>((event, emit) async {
      emit(SeriesTopRatedLoading());
      final result = await getTopRatedTVSeries.execute();
      result.fold(
            (failure) {
          emit(SeriesTopRatedError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesTopRatedEmpty());
          } else {
            emit(SeriesTopRatedHasData(data));
          }
        },
      );
    });
  }
}
