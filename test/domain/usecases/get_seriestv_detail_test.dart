import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_seriestv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  final tId = 1;

  test('should get TV Series detail from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVSeriesDetail));
  });
}
