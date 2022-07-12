import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_seriestv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetTVSeriesRecommendations usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesRecommendations(mockTVSeriesRepository);
  });

  final tId = 1;
  final tTVSeries = <SeriesTV>[];

  test('should get list of TV Series recommendations from the repository',
          () async {
        // arrange
        when(mockTVSeriesRepository.getTVSeriesRecommendations(tId))
            .thenAnswer((_) async => Right(tTVSeries));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTVSeries));
      });
}
