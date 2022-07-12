import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/seriestv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/seriestv_bloc/watchlist_series_tv_bloc.dart';

class WatchlistSeriesTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistSeriesTVPageState createState() => _WatchlistSeriesTVPageState();
}

class _WatchlistSeriesTVPageState extends State<WatchlistSeriesTVPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesWatchlistBloc>().add(OnSeriesWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<SeriesWatchlistBloc>().add(OnSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesWatchlistBloc, SeriesWatchlistState>(
          builder: (context, state) {
            if (state is SeriesWatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesWatchlistHasData) {
              final result = state.result;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final series = result[index];
                        return SeriesTVCard(series);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            } else if (state is SeriesWatchlistEmpty) {
              return Center(
                child: Text("watchlist is empty"),
              );
            } else if (state is SeriesWatchlistError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error get data watchlist"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
