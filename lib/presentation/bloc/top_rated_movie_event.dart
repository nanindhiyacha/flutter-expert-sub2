part of 'top_rated_movie_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable{
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMoviesEvent extends TopRatedMoviesEvent {}
