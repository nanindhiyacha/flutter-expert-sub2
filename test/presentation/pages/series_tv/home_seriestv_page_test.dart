import 'package:ditonton/presentation/bloc/seriestv_bloc/on_the_air_seriestv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/pages/home_seriestv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularTvShowBloc extends Mock implements SeriesPopularBloc {}

class FakePopularEvent extends Fake implements SeriesPopularEvent {}

class FakePopularState extends Fake implements SeriesPopularState {}

class MockTopRatedTvShowBloc extends Mock implements SeriesTopRatedBloc {}

class FakeTopRatedEvent extends Fake implements SeriesTopRatedEvent {}

class FakeTopRatedState extends Fake implements SeriesTopRatedState {}

class MockNowPlayingTvShowBloc extends Mock implements SeriesOnTheAirBloc {}

class NowPlayingtvStateFake extends Fake implements SeriesOnTheAirState {}

class NowPlayingtvEventFake extends Fake implements SeriesOnTheAirEvent {}

void main() {
  late MockPopularTvShowBloc mockPopularTvShowBloc;
  late MockNowPlayingTvShowBloc mockNowPlayingTvShowBloc;
  late MockTopRatedTvShowBloc mockTopRateTvShowBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularEvent());
    registerFallbackValue(FakePopularState());
    registerFallbackValue(FakeTopRatedEvent());
    registerFallbackValue(FakeTopRatedState());
    registerFallbackValue(NowPlayingtvStateFake());
    registerFallbackValue(NowPlayingtvEventFake());
  });

  setUp(() {
    mockPopularTvShowBloc = MockPopularTvShowBloc();
    mockNowPlayingTvShowBloc = MockNowPlayingTvShowBloc();
    mockTopRateTvShowBloc = MockTopRatedTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeriesPopularBloc>.value(value: mockPopularTvShowBloc),
        BlocProvider<SeriesOnTheAirBloc>.value(
            value: mockNowPlayingTvShowBloc),
        BlocProvider<SeriesTopRatedBloc>.value(value: mockTopRateTvShowBloc),
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
      when(() => mockPopularTvShowBloc.stream)
          .thenAnswer(((_) => Stream.value(SeriesPopularLoading())));
      when(() => mockPopularTvShowBloc.state)
          .thenReturn(SeriesPopularLoading());
      //now playing
      when(() => mockNowPlayingTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(OnTheAirTvseriesLoading()));
      when(() => mockNowPlayingTvShowBloc.state)
          .thenReturn(OnTheAirTvseriesLoading());
      //top rated
      when(() => mockTopRateTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(SeriesTopRatedLoading()));
      when(() => mockTopRateTvShowBloc.state)
          .thenReturn(SeriesTopRatedLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(SeriesTVPage()));

      expect(progressFinder, findsNWidgets(3));
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      when(() => mockPopularTvShowBloc.stream)
          .thenAnswer(((_) => Stream.value(SeriesPopularHasData(tTvList))));
      when(() => mockPopularTvShowBloc.state)
          .thenReturn(SeriesPopularHasData(tTvList));
      //now playing
      when(() => mockNowPlayingTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(OnTheAirTvseriesHasData(tTvList)));
      when(() => mockNowPlayingTvShowBloc.state)
          .thenReturn(OnTheAirTvseriesHasData(tTvList));
      //top rated
      when(() => mockTopRateTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(SeriesTopRatedHasData(tTvList)));
      when(() => mockTopRateTvShowBloc.state)
          .thenReturn(SeriesTopRatedHasData(tTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(SeriesTVPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );
}
