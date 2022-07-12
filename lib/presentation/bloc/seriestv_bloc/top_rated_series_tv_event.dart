part of 'top_rated_series_tv_bloc.dart';

abstract class SeriesTopRatedEvent extends Equatable{
  const SeriesTopRatedEvent();
}

class OnSeriesTopRatedShow extends SeriesTopRatedEvent {
  @override
  List<Object?> get props => [];
}
