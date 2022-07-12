import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTopRatedSeriesTV {
  final TVSeriesRepository repository;

  GetTopRatedSeriesTV(this.repository);

  Future<Either<Failure, List<SeriesTV>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
