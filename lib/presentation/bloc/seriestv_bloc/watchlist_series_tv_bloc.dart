import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/seriestv/series_tv_detail.dart';
import '../../../domain/usecases/get_watchlist_seriestv_status.dart';
import '../../../domain/usecases/remove_seriestv_watchlist.dart';
import '../../../domain/usecases/save_seriestv_watchlist.dart';

part 'watchlist_series_tv_event.dart';
part 'watchlist_series_tv_state.dart';

class SeriesWatchlistBloc extends Bloc<SeriesWatchlistEvent, SeriesWatchlistState> {
  final GetWatchlistSeriesTV getWatchlistTVSeries;
  final GetWatchListTVSeriesStatus getWatchListTVSeriesStatus;
  final RemoveTVSeriesWatchlist removeTVSeriesWatchlist;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;

  SeriesWatchlistBloc(
      this.getWatchlistTVSeries,
      this.getWatchListTVSeriesStatus,
      this.removeTVSeriesWatchlist,
      this.saveTVSeriesWatchlist
      ) : super(SeriesWatchlistEmpty()) {
    on<OnSeriesWatchlist>((event, emit) async{
      emit(SeriesWatchlistLoading());

      final result = await getWatchlistTVSeries.execute();

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesWatchlistEmpty());
          } else {
            emit(SeriesWatchlistHasData(data));
          }
        },
      );
    });
    on<SeriesWatchlist>((event, emit) async {

      final id = event.id;

      final result = await getWatchListTVSeriesStatus.execute(id);

      emit(AddWatchlist(result));
    });

    on<AddSeriesWatchlist>((event, emit) async {
      emit(SeriesWatchlistLoading());
      final movie = event.seriesDetail;

      final result = await saveTVSeriesWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (message) {
          emit(MessageSeriesWatchlist(message));
        },
      );
    });

    on<DeleteSeriesWatchlist>((event, emit) async {
      final movie = event.seriesDetail;

      final result = await removeTVSeriesWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (message) {
          emit(MessageSeriesWatchlist(message));
        },
      );
    });
  }
}
