import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/failure.dart';

class SaveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  SaveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SeriesTVDetail movie) {
    return repository.saveSeriesTVWatchlist(movie);
  }
}
