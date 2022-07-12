import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, SeriesTVDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
