import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistSeriesTV {
  final TVSeriesRepository _repository;

  GetWatchlistSeriesTV(this._repository);

  Future<Either<Failure, List<SeriesTV>>> execute() {
    return _repository.getTVSeriesWatchlist();
  }
}
