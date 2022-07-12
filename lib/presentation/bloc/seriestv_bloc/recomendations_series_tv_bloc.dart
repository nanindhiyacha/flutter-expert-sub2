import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_seriestv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'recomendations_series_tv_event.dart';
part 'recomendations_series_tv_state.dart';

class SeriesRecommendationBloc extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  SeriesRecommendationBloc(this.getTVSeriesRecommendations) : super(SeriesRecommendationEmpty()) {
    on<OnRecommendationTvSeriesShow>((event, emit) async{
      final id = event.id;
      emit(SeriesRecommendationLoading());
      final result = await getTVSeriesRecommendations.execute(id);

      result.fold(
            (failure) {
          emit(SeriesRecommendationError(failure.message));
        },
            (data) {
          emit(SeriesRecommendationHasData(data));
        },
      );
    });
  }
}