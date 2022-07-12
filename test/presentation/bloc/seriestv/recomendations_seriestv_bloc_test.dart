import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_seriestv_recommendations.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/recomendations_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recomendations_seriestv_bloc_test.mocks.dart';


@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late SeriesRecommendationBloc seriesRecommendationBloc;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;

  setUp(() {
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    seriesRecommendationBloc =
        SeriesRecommendationBloc(mockGetTVSeriesRecommendations);
  });

  const tId = 1;

  final tTvSeries = SeriesTV(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    firstAirDate: "1997-09-13",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
    "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tTvSeriesList = <SeriesTV>[tTvSeries];

  group('bloc recomendation tv series testing', () {
    test('initial state should be empty', () {
      expect(seriesRecommendationBloc.state, SeriesRecommendationEmpty());
    });

    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return seriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTvSeriesShow(tId)),
      expect: () => [
        SeriesRecommendationLoading(),
        SeriesRecommendationHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesRecommendations.execute(tId));
        return OnRecommendationTvSeriesShow(tId).props;
      },
    );

    blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTvSeriesShow(tId)),
      expect: () => [
        SeriesRecommendationLoading(),
        SeriesRecommendationError('Server Failure'),
      ],
      verify: (bloc) => SeriesRecommendationLoading(),
    );
  });
}