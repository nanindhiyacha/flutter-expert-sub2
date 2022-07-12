import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_seriestv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetWatchlistSeriesTV usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchlistSeriesTV(mockTVSeriesRepository);
  });

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesWatchlist())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
