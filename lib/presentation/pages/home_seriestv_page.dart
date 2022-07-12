import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/popular_seriestv_page.dart';
import 'package:ditonton/presentation/pages/seriestv_detail_page.dart';
import 'package:ditonton/presentation/pages/seriestv_search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_seriestv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/watchlist_seriestv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/seriestv_bloc/on_the_air_seriestv_bloc.dart';
import '../bloc/seriestv_bloc/popular_series_tv_bloc.dart';
import '../bloc/seriestv_bloc/top_rated_series_tv_bloc.dart';

class SeriesTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _SeriesTVPageState createState() => _SeriesTVPageState();
}

class _SeriesTVPageState extends State<SeriesTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesOnTheAirBloc>().add(OnTheAirTvseriesShow());
      context.read<SeriesPopularBloc>().add(OnPopularTvSeriesShow());
      context.read<SeriesTopRatedBloc>().add(OnSeriesTopRatedShow());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Movie',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context,HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            Divider(
              color: Colors.white,
              height: 20,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'TV Series',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('TV Series Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistSeriesTVPage.ROUTE_NAME);
              },
            ),
            Divider(
              color: Colors.white,
              height: 20,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageSeriesTV.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On Air',
                style: kHeading6,
              ),
              BlocBuilder<SeriesOnTheAirBloc, SeriesOnTheAirState>(
                builder: (context, state) {
                  if (state is OnTheAirTvseriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirTvseriesHasData) {
                    final data = state.result;
                    return TVSeriesList(data);
                  } else if (state is OnTheAirTvseriesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSeriesTVPage.ROUTE_NAME),
              ),
              BlocBuilder<SeriesPopularBloc, SeriesPopularState>(
                builder: (context, state) {
                  if (state is SeriesPopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SeriesPopularHasData) {
                    final data = state.result;
                    return TVSeriesList(data);
                  } else if (state is SeriesPopularError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSeriesTVPage.ROUTE_NAME),
              ),
              BlocBuilder<SeriesTopRatedBloc, SeriesTopRatedState>(
                builder: (context, state) {
                  if (state is SeriesTopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SeriesTopRatedHasData) {
                    final data = state.result;
                    return TVSeriesList(data);
                  } else if (state is SeriesTopRatedError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<SeriesTV> tvSeries;

  TVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesTVDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
