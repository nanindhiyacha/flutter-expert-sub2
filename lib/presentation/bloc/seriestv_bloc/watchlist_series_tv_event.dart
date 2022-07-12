part of 'watchlist_series_tv_bloc.dart';

@immutable
abstract class SeriesWatchlistEvent extends Equatable{
  const SeriesWatchlistEvent();
}

class OnSeriesWatchlist extends SeriesWatchlistEvent {
  @override
  List<Object> get props => [];
}

class SeriesWatchlist extends SeriesWatchlistEvent {
  final int id;

  SeriesWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class AddSeriesWatchlist extends SeriesWatchlistEvent {
  final SeriesTVDetail seriesDetail;

  AddSeriesWatchlist(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}

class DeleteSeriesWatchlist extends SeriesWatchlistEvent {
  final SeriesTVDetail seriesDetail;

  DeleteSeriesWatchlist(this.seriesDetail);

  @override
  List<Object> get props => [seriesDetail];
}