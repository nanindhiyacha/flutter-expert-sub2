import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/seriestv_local_data_source.dart';
import 'package:ditonton/data/datasources/seriestv_remote_data_source.dart';
import 'package:ditonton/data/models/series/seriestv_table.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:ditonton/domain/repositories/seriestv_repository.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class SeriesTVRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource remoteDataSource;
  final TVSeriesLocalDataSource localDataSource;

  SeriesTVRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SeriesTV>>> getOnTheAirTVSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SeriesTVDetail>> getTVSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SeriesTV>>> getTVSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SeriesTV>>> getPopularTVSeries() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SeriesTV>>> getTopRatedTVSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SeriesTV>>> searchTVSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveSeriesTVWatchlist(
      SeriesTVDetail tvSeries) async {
    try {
      final result = await localDataSource
          .insertTVSeriesWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeSeriesTVFromWatchlist(
      SeriesTVDetail tvSeries) async {
    try {
      final result = await localDataSource
          .removeTVSeriesWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isTVSeriesAddedToWatchlist(int id) async {
    final result = await localDataSource.getTVSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<SeriesTV>>> getTVSeriesWatchlist() async {
    final result = await localDataSource.getWatchlistTVSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
