import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
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
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/home_seriestv_page.dart';
import 'package:ditonton/presentation/pages/seriestv_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_seriestv_page.dart';
import 'package:ditonton/presentation/pages/seriestv_search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_seriestv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_seriestv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/ssl_spinning.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider<MoviesDetailBloc>(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider<NowplayingMovieBloc>(
          create: (_) => di.locator<NowplayingMovieBloc>(),
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider<MovieRecomendationBloc>(
          create: (_) => di.locator<MovieRecomendationBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case SeriesTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SeriesTVPage());
            case PopularSeriesTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesTVPage());
            case TopRatedSeriesTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesTVPage());
            case SeriesTVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesTVDetailPage(id: id),
                settings: settings,
              );
            case SearchPageSeriesTV.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageSeriesTV());
            case WatchlistSeriesTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesTVPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
