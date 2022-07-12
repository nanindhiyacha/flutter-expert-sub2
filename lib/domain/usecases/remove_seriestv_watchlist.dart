import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/failure.dart';

class RemoveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  RemoveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SeriesTVDetail movie) {
    return repository.removeSeriesTVFromWatchlist(movie);
  }
}
