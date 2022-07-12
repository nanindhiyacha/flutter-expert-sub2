import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import '../../dummy_data/dummy_objects.dart';
import 'nowplaying_movie_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies usecase;
  late NowplayingMovieBloc bloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    bloc = NowplayingMovieBloc(getNowPlayingMovies: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, NowplayingMovieInitial());
  });

  blocTest<NowplayingMovieBloc, NowplayingMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNowplayingMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowplayingMovieLoading(),
      NowplayingMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );

  blocTest<NowplayingMovieBloc, NowplayingMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNowplayingMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowplayingMovieLoading(),
      NowplayingMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );
}
