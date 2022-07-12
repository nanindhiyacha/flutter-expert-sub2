
import 'package:ditonton/presentation/widgets/seriestv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/seriestv_bloc/popular_series_tv_bloc.dart';

class PopularSeriesTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularSeriesTVPageState createState() => _PopularSeriesTVPageState();
}

class _PopularSeriesTVPageState extends State<PopularSeriesTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesPopularBloc>().add(OnPopularTvSeriesShow());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesPopularBloc, SeriesPopularState>(
          builder: (context, state) {
            if (state is SeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesPopularHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = result[index];
                  return SeriesTVCard(tvSeries);
                },
                itemCount: result.length,
              );
            } else if (state is SeriesPopularError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('no_data_message'),
                child: Text("No popular shows"),
              );
            }
          },
        ),
      ),
    );
  }
}
