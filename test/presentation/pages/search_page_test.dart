import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieSearchBloc extends Mock implements SearchBloc {}

class FakeEvent extends Fake implements SearchEvent {}

class FakeState extends Fake implements SearchState {}

void main() {
  late MockMovieSearchBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockMovieSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
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
          .thenAnswer((_) => Stream.value(SearchLoaded(testMovieList)));
      when(() => bloc.state).thenReturn(SearchLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SearchLoading()));
      when(() => bloc.state).thenReturn(SearchLoading());

      final progresBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(progresBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display error message when error",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(SearchError(tError)));
      when(() => bloc.state).thenReturn(SearchError(tError));

      final textFinder = find.text(tError);

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
