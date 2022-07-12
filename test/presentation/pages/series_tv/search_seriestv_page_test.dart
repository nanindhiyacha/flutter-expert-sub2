import 'package:ditonton/presentation/bloc/seriestv_bloc/search_series_tv_bloc.dart';
import 'package:ditonton/presentation/pages/seriestv_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockTvSearchBloc extends Mock implements SeriesSearchBloc {}

class FakeEvent extends Fake implements SeriesSearchEvent {}

class FakeState extends Fake implements SeriesSearchState {}

void main() {
  late MockTvSearchBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockTvSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesSearchBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SeriesSearchHasData(tTvList)));
      when(() => bloc.state).thenReturn(SeriesSearchHasData(tTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(SearchPageSeriesTV()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SeriesSearchLoading()));
      when(() => bloc.state).thenReturn(SeriesSearchLoading());

      final progresBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(SearchPageSeriesTV()));

      expect(progresBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display error message when error",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SeriesSearchError(tError)));
      when(() => bloc.state).thenReturn(SeriesSearchError(tError));

      final textFinder = find.text(tError);

      await tester.pumpWidget(_makeTestableWidget(SearchPageSeriesTV()));

      expect(textFinder, findsOneWidget);
    },
  );
}
