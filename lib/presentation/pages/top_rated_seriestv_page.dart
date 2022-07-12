import 'package:ditonton/presentation/widgets/seriestv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/seriestv_bloc/top_rated_series_tv_bloc.dart';

class TopRatedSeriesTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedSeriesTVPageState createState() => _TopRatedSeriesTVPageState();
}

class _TopRatedSeriesTVPageState extends State<TopRatedSeriesTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesTopRatedBloc>().add(OnSeriesTopRatedShow());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesTopRatedBloc, SeriesTopRatedState>(
          builder: (context, state) {
            if (state is SeriesTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesTopRatedHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = result[index];
                  return SeriesTVCard(tvSeries);
                },
                itemCount: result.length,
              );
            } else if (state is SeriesTopRatedError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('no_data_message'),
                child: Text("No top rated shows"),
              );
            }
          },
        ),
      ),
    );
  }
}
