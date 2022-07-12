import 'package:ditonton/domain/usecases/get_watchlist_seriestv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetWatchListTVSeriesStatus usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchListTVSeriesStatus(mockTVSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isTVSeriesAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
