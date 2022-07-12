part of 'recomendations_series_tv_bloc.dart';

@immutable
abstract class SeriesRecommendationState extends Equatable{
  const SeriesRecommendationState();
  @override
  List<Object> get props => [];
}

class SeriesRecommendationEmpty extends SeriesRecommendationState {
  @override
  List<Object> get props => [];
}

class SeriesRecommendationLoading extends SeriesRecommendationState {
  @override
  List<Object> get props => [];
}

class SeriesRecommendationHasData extends SeriesRecommendationState {
  final List<SeriesTV> result;

  SeriesRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesRecommendationError extends SeriesRecommendationState {
  final String message;
  SeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

