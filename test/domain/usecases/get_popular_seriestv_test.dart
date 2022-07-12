import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_seriestv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/seriestv_test_helper.mocks.dart';

void main() {
  late GetPopularSeriesTV usecase;
  late MockTVSeriesRepository mockTVSeriesRpository;

  setUp(() {
    mockTVSeriesRpository = MockTVSeriesRepository();
    usecase = GetPopularSeriesTV(mockTVSeriesRpository);
  });

  final tTVSeries = <SeriesTV>[];

  group('GetPopularTV Series Tests', () {
    group('execute', () {
      test(
          'should get list of TV Series from the repository when execute function is called',
              () async {
            // arrange
            when(mockTVSeriesRpository.getPopularTVSeries())
                .thenAnswer((_) async => Right(tTVSeries));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTVSeries));
          });
    });
  });
}
