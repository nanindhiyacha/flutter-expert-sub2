part of 'search_series_tv_bloc.dart';

@immutable
abstract class SeriesSearchState extends Equatable {
  const SeriesSearchState();
  @override
  List<Object> get props => [];
}
class SeriesSearchEmpty extends SeriesSearchState {}

class SeriesSearchLoading extends SeriesSearchState {}

class SeriesSearchHasData extends SeriesSearchState {
  final List<SeriesTV> result;

  SeriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesSearchError extends SeriesSearchState {
  final String message;

  SeriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

