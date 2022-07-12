import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

part 'populer_movie_event.dart';
part 'populer_movie_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await getPopularMovies.execute();

      result.fold(
            (failure) => emit(PopularMoviesError(failure.message)),
            (result) => emit(PopularMoviesLoaded(result)),
      );
    });
  }
}