part of 'nowplaying_movie_bloc.dart';

@immutable
abstract class NowplayingMovieEvent extends Equatable {
  const NowplayingMovieEvent();

  @override
  List<Object> get props => [];
}
class GetNowplayingMovieEvent extends NowplayingMovieEvent {}


