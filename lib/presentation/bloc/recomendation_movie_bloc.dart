import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_recommendations.dart';

part 'recomendation_movie_event.dart';
part 'recomendation_movie_state.dart';

class MovieRecomendationBloc extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetMovieRecommendations getMovierecomandations;
  MovieRecomendationBloc({required this.getMovierecomandations}) : super(MovieRecomendationInitial()) {
    on<GetMovieRecomendationEvent>((event, emit) async {
      emit(MovieRecomendationLoading());
      final result = await getMovierecomandations.execute(event.id);

      result.fold(
            (failure) => emit(MovieRecomendationError(failure.message)),
            (result) => emit(MovieRecomendationLoaded(result)),
      );
    });
  }
}
