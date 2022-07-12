part of 'recomendations_series_tv_bloc.dart';

abstract class SeriesRecommendationEvent extends Equatable{
  const SeriesRecommendationEvent();
}
class OnRecommendationTvSeriesShow extends SeriesRecommendationEvent {
  final int id;

  OnRecommendationTvSeriesShow(this.id);

  @override
  List<Object?> get props => [];
}