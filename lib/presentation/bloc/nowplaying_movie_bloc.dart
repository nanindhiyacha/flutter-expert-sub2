
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';

part 'nowplaying_movie_event.dart';
part 'nowplaying_movie_state.dart';

class NowplayingMovieBloc extends Bloc<NowplayingMovieEvent, NowplayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowplayingMovieBloc({required this.getNowPlayingMovies}) : super(NowplayingMovieInitial()) {
    on<NowplayingMovieEvent>((event, emit)  async {
      emit(NowplayingMovieLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
            (failure) => emit(NowplayingMovieError(failure.message)),
            (result) => emit(NowplayingMovieLoaded(result)),
      );
    });
  }
}
