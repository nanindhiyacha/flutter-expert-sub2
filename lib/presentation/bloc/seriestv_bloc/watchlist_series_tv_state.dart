part of 'watchlist_series_tv_bloc.dart';

abstract class SeriesWatchlistState extends Equatable{
  const SeriesWatchlistState();
  @override
  List<Object> get props => [];
}

class SeriesWatchlistEmpty extends SeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class SeriesWatchlistLoading extends SeriesWatchlistState {
  @override
  List<Object> get props => [];
}

class SeriesWatchlistHasData extends SeriesWatchlistState {
  final List<SeriesTV> result;

  SeriesWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesWatchlistError extends SeriesWatchlistState {
  final String message;
  SeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddWatchlist extends SeriesWatchlistState {
  final bool status;

  AddWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageSeriesWatchlist extends SeriesWatchlistState {
  final String message;

  MessageSeriesWatchlist(this.message);

  @override
  List<Object> get props => [message];
}