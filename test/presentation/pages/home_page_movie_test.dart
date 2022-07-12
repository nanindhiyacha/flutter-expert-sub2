import 'package:ditonton/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/populer_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMovieBloc extends Mock implements NowplayingMovieBloc {}

class NowPlayingMovieStateFake extends Fake implements NowplayingMovieState {}

class NowPlayingMovieEventFake extends Fake implements NowplayingMovieEvent {}

class MockPopulerMovieBloc extends Mock implements PopularMoviesBloc {}

class PopularMovieStateFake extends Fake implements PopularMoviesState {}

class PopularMovieEventFake extends Fake implements PopularMoviesEvent {}

class MockTopRatedMovieBloc extends Mock implements TopRatedMoviesBloc {}

class TopRatedMovieStateFake extends Fake implements TopRatedMoviesState {}

class TopRatedMovieEventFake extends Fake implements TopRatedMoviesEvent {}

void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;
  late MockPopulerMovieBloc mockPopulerMovieBloc;
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingMovieStateFake());
    registerFallbackValue(NowPlayingMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(TopRatedMovieStateFake());
    registerFallbackValue(TopRatedMovieEventFake());
  });

  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
    mockPopulerMovieBloc = MockPopulerMovieBloc();
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>.value(value: mockPopulerMovieBloc),
        BlocProvider<NowplayingMovieBloc>.value(value: mockNowPlayingMovieBloc),
        BlocProvider<TopRatedMoviesBloc>.value(value: mockTopRatedMovieBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMoviesLoading())));
      when(() => mockPopulerMovieBloc.state).thenReturn(PopularMoviesLoading());
      //now playing
      when(() => mockNowPlayingMovieBloc.stream)
          .thenAnswer((_) => Stream.value(NowplayingMovieLoading()));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowplayingMovieLoading());
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMoviesLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(progressFinder, findsNWidgets(3));
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMoviesLoaded(testMovieList))));
      when(() => mockPopulerMovieBloc.state)
          .thenReturn(PopularMoviesLoaded(testMovieList));
      //now playing
      when(() => mockNowPlayingMovieBloc.stream).thenAnswer(
              (_) => Stream.value(NowplayingMovieLoaded(testMovieList)));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowplayingMovieLoaded(testMovieList));
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMoviesLoaded(testMovieList)));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMoviesLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display text with message when Error",
        (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMoviesError(tError))));
      when(() => mockPopulerMovieBloc.state)
          .thenReturn(PopularMoviesError(tError));
      //now playing
      when(() => mockNowPlayingMovieBloc.stream)
          .thenAnswer((_) => Stream.value(NowplayingMovieError(tError)));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowplayingMovieError(tError));
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMoviesError(tError)));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMoviesError(tError));

      final textFinder = find.text("Failed");

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
