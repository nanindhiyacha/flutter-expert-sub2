import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMoviesBloc({required this.getWatchlistMovies}) : super(WatchlistMoviesEmpty()) {
    on<WatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
            (failure) => emit(WatchlistMoviesError(failure.message)),
            (result) => emit(WatchlistMoviesLoaded(result)),
      );
    });
  }
}