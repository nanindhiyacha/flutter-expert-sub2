import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_seriestv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late RemoveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should remove watchlist TV Series from repository', () async {
    // arrange
    when(mockTVSeriesRepository.removeSeriesTVFromWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.removeSeriesTVFromWatchlist(testTVSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
