part of 'seriestv_detail_bloc.dart';

abstract class SeriesDetailState extends Equatable{
  const SeriesDetailState();
  @override
  List<Object> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {
  @override
  List<Object> get props => [];
}

class SeriesDetailLoading extends SeriesDetailState {
  @override
  List<Object> get props => [];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesTVDetail result;

  SeriesDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesDetailError extends SeriesDetailState {
  final String message;
  SeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}




