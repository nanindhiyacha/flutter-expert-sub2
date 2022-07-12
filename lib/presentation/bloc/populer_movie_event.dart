part of 'populer_movie_bloc.dart';

@immutable
abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends PopularMoviesEvent {}
