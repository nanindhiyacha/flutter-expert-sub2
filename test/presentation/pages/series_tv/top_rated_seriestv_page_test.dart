import 'package:ditonton/presentation/bloc/seriestv_bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_seriestv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTopRatedTvShowBloc extends Mock implements SeriesTopRatedBloc {}

class FakeEvent extends Fake implements SeriesTopRatedEvent {}

class FakeState extends Fake implements SeriesTopRatedState {}

void main() {
  late MockTopRatedTvShowBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockTopRatedTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesTopRatedBloc>.value(
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
          .thenAnswer((_) => Stream.value(SeriesTopRatedLoading()));
      when(() => bloc.state).thenReturn(SeriesTopRatedLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesTVPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SeriesTopRatedHasData(tTvList)));
      when(() => bloc.state).thenReturn(SeriesTopRatedHasData(tTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesTVPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SeriesTopRatedError(tError)));
      when(() => bloc.state).thenReturn(SeriesTopRatedError(tError));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesTVPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
