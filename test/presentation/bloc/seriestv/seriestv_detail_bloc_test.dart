import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_season.dart';
import 'package:ditonton/domain/usecases/get_seriestv_detail.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/seriestv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'seriestv_detail_bloc_test.mocks.dart';



@GenerateMocks([GetTVSeriesDetail])
void main() {
  late SeriesDetailBloc seriesDetailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    seriesDetailBloc = SeriesDetailBloc(mockGetTVSeriesDetail);
  });

  final tId = 1;

  final testTvSeriesDetail = SeriesTVDetail(
    adult: false,
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    episodeRunTime: [42],
    genres: [Genre(id: 18, name: 'Drama')],
    homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
    id: 1,
    name: "name",
    numberOfEpisodes: 259,
    numberOfSeasons: 2,
    originalName: "Pasión de gavilanes",
    overview: "overview",
    popularity: 1747.047,
    posterPath: "posterPath",
    seasons: [
      Season(
        episodeCount: 188,
        id: 72643,
        name: "Season 1",
        posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
        seasonNumber: 1,
      )
    ],
    status: "Returning Series",
    type: "Scripted",
    voteAverage: 7.6,
    voteCount: 1803,
  );

  group('bloc detail tv series testing', () {
    test('initial state should be empty', () {
      expect(seriesDetailBloc.state, SeriesDetailEmpty());
    });

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnSeriesDetailShow(tId)),
      expect: () => [
        SeriesDetailLoading(),
        SeriesDetailHasData(testTvSeriesDetail),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
        return OnSeriesDetailShow(tId).props;
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnSeriesDetailShow(tId)),
      expect: () => [
        SeriesDetailLoading(),
        SeriesDetailError('Server Failure'),
      ],
      verify: (bloc) => SeriesDetailLoading(),
    );
  });
}
