import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_seriestv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late SaveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should save TV Series to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveSeriesTVWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.saveSeriesTVWatchlist(testTVSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
