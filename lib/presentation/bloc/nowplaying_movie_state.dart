part of 'nowplaying_movie_bloc.dart';

@immutable
abstract class NowplayingMovieState extends Equatable {
  const NowplayingMovieState();

  @override
  List<Object> get props => [];
}

class NowplayingMovieInitial extends NowplayingMovieState {}

class NowplayingMovieLoading extends NowplayingMovieState {}

class NowplayingMovieLoaded extends NowplayingMovieState {
  final List<Movie> result;

  NowplayingMovieLoaded(this.result);
}

class NowplayingMovieError extends NowplayingMovieState {
  final String message;

  NowplayingMovieError(this.message);
}
