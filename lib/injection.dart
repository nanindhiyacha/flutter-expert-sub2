import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/seriestv_local_data_source.dart';
import 'package:ditonton/data/datasources/seriestv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/seriestv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/get_seriestv_detail.dart';
import 'package:ditonton/domain/usecases/get_seriestv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_on_air_seriestv.dart';
import 'package:ditonton/domain/usecases/get_popular_seriestv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_seriestv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv_status.dart';
import 'package:ditonton/domain/usecases/remove_seriestv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_seriestv_watchlist.dart';
import 'package:ditonton/domain/usecases/search_seriestv.dart';
import 'package:ditonton/presentation/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/populer_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/on_the_air_seriestv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/recomendations_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/search_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/seriestv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/seriestv_bloc/watchlist_series_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_event_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_status_bloc.dart';

import 'package:get_it/get_it.dart';

import 'common/ssl_spinning.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () =>  MoviesDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
        () => NowplayingMovieBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => SearchBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistEventBloc(
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistStatusBloc(
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecomendationBloc(
      getMovierecomandations: locator(),
    ),
  );

  // provider tvseries

  locator.registerFactory(
        () => SeriesDetailBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesRecommendationBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesSearchBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesOnTheAirBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesPopularBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesTopRatedBloc(locator(),
    ),
  );
  locator.registerFactory(
        () => SeriesWatchlistBloc(locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case TV Series
  locator.registerLazySingleton(() => GetOnTheAirSeriesTV(locator()));
  locator.registerLazySingleton(() => GetPopularSeriesTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeriesTV(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTVSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeriesTV(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository TV Series
  locator.registerLazySingleton<TVSeriesRepository>(
        () => SeriesTVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );


  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources TV Series
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
          () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
          () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
