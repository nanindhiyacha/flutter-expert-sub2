import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc extends Mock implements WatchlistMoviesBloc {}

class FakeEvent extends Fake implements WatchlistMoviesEvent {}

class FakeState extends Fake implements WatchlistMoviesState {}

void main() {
  late MockWatchlistMovieBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMoviesLoading()));
      when(() => bloc.state).thenReturn(WatchlistMoviesLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(progressFinder, findsOneWidget);
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMoviesLoaded(testMovieList)));
      when(() => bloc.state).thenReturn(WatchlistMoviesLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMoviesError(tError)));
      when(() => bloc.state).thenReturn(WatchlistMoviesError(tError));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
