part of 'recomendation_movie_bloc.dart';

@immutable
abstract class MovieRecomendationEvent extends Equatable{
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecomendationEvent extends MovieRecomendationEvent {
  final int id;

  GetMovieRecomendationEvent(this.id);
}