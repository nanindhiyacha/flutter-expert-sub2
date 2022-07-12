import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<SeriesTV>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<SeriesTV>>> getPopularTVSeries();
  Future<Either<Failure, List<SeriesTV>>> getTopRatedTVSeries();
  Future<Either<Failure, SeriesTVDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<SeriesTV>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<SeriesTV>>> searchTVSeries(String query);
  Future<Either<Failure, String>> saveSeriesTVWatchlist(
      SeriesTVDetail movie);
  Future<Either<Failure, String>> removeSeriesTVFromWatchlist(
      SeriesTVDetail movie);
  Future<bool> isTVSeriesAddedToWatchlist(int id);
  Future<Either<Failure, List<SeriesTV>>> getTVSeriesWatchlist();
}
