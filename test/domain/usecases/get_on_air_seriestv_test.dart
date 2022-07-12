import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_on_air_seriestv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetOnTheAirSeriesTV usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetOnTheAirSeriesTV(mockTVSeriesRepository);
  });

  final tTVSeries = <SeriesTV>[];

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getOnTheAirTVSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
