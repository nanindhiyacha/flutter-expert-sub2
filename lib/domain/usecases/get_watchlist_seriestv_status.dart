import 'package:ditonton/domain/repositories/seriestv_repository.dart';

class GetWatchListTVSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchListTVSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTVSeriesAddedToWatchlist(id);
  }
}
