part of 'top_rated_series_tv_bloc.dart';

abstract class SeriesTopRatedState extends Equatable {
  const SeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class SeriesTopRatedEmpty extends SeriesTopRatedState {
  @override
  List<Object> get props => [];
}
class SeriesTopRatedLoading extends SeriesTopRatedState {
  @override
  List<Object> get props => [];
}

class SeriesTopRatedHasData extends SeriesTopRatedState {
  final List<SeriesTV> result;

  SeriesTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesTopRatedError extends SeriesTopRatedState {
  final String message;

  SeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}


