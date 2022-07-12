
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(TopRatedMoviesInitial()) {
    on<TopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
            (failure) => emit(TopRatedMoviesError(failure.message)),
            (result) => emit(TopRatedMoviesLoaded(result)),
      );
    });
  }
}
