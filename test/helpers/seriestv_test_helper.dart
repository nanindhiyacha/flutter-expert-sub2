import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/seriestv_local_data_source.dart';
import 'package:ditonton/data/datasources/seriestv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
