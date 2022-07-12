import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'watchlist_event_event.dart';
part 'watchlist_event_state.dart';

class WatchlistEventBloc extends Bloc<WatchlistEventEvent, WatchlistEventState> {
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  WatchlistEventBloc({required this.saveWatchlist, required this.removeWatchlist}) : super(WatchlistEventInitial()) {
    on<RemoveWatchlistMovies>((event, emit) async {
      emit(WatchlistEventLoading());
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
            (failure) => emit(WatchlistEventError(failure.message)),
            (result) => emit(WatchlistEventLoaded(result)),
      );
    });
    on<AddWatchlistMovies>((event, emit) async {
      emit(WatchlistEventLoading());
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
            (failure) => emit(WatchlistEventError(failure.message)),
            (result) => emit(WatchlistEventLoaded(result)),
      );
    });
  }
}