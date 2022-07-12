import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_season.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv_status.dart';
import 'package:ditonton/domain/usecases/remove_seriestv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_seriestv_watchlist.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/watchlist_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_series_tv_bloc_test.mocks.dart';


@GenerateMocks([
  GetWatchlistSeriesTV,
  GetWatchListTVSeriesStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist,
])
void main() {
  late SeriesWatchlistBloc seriesWatchlistBloc;
  late MockGetWatchlistSeriesTV mockGetWatchlistTVSeries;
  late MockGetWatchListTVSeriesStatus mockGetWatchListTVSeriesStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistSeriesTV();
    mockGetWatchListTVSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();
    seriesWatchlistBloc = SeriesWatchlistBloc(
      mockGetWatchlistTVSeries,
      mockGetWatchListTVSeriesStatus,
      mockRemoveTVSeriesWatchlist,
      mockSaveTVSeriesWatchlist,
    );
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

  group('bloc watch list tv series testing', () {
    test('initial state should be empty', () {
      expect(seriesWatchlistBloc.state, SeriesWatchlistEmpty());
    });

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when( mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnSeriesWatchlist()),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
        return OnSeriesWatchlist().props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when( mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnSeriesWatchlist()),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistError('Server Failure'),
      ],
      verify: (bloc) => SeriesWatchlistLoading(),
    );
  });

  group('bloc status watch list tv series testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(SeriesWatchlist(tId)),
      expect: () => [AddWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListTVSeriesStatus.execute(tId));
        return SeriesWatchlist(tId).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(SeriesWatchlist(tId)),
      expect: () => [AddWatchlist(false)],
      verify: (bloc) => SeriesWatchlistLoading(),
    );
  });

  group('bloc add watch list tv series testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddSeriesWatchlist(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistLoading(),
        MessageSeriesWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return AddSeriesWatchlist(testTvSeriesDetail).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveTVSeriesWatchlist.execute(testTvSeriesDetail)).thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddSeriesWatchlist(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistLoading(),
        SeriesWatchlistError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => AddSeriesWatchlist(testTvSeriesDetail),
    );
  });

  group('bloc remove watch list tv series testing', () {
    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteSeriesWatchlist(testTvSeriesDetail)),
      expect: () => [
        MessageSeriesWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail));
        return DeleteSeriesWatchlist(testTvSeriesDetail).props;
      },
    );

    blocTest<SeriesWatchlistBloc, SeriesWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveTVSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return seriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteSeriesWatchlist(testTvSeriesDetail)),
      expect: () => [
        SeriesWatchlistError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteSeriesWatchlist(testTvSeriesDetail),
    );
  });
}