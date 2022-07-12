import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail getMovieDetail;
  MoviesDetailBloc({required this.getMovieDetail}) : super(MoviesDetailInitial()) {
    on<OnDetailMoviesShow>((event, emit) async {
      emit(MoviesDetailLoading());
      final result = await getMovieDetail.execute(event.id);

      result.fold(
            (failure) => emit(MoviesDetailError(failure.message)),
            (result) => emit(MoviesDetailHasData(result)),
      );
    });
  }
}