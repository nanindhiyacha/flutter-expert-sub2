import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_season.dart';
import 'package:equatable/equatable.dart';

class SeriesTVDetail extends Equatable {
  final int id;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final bool adult;
  final String name;
  final String type;
  final String status;
  final String homepage;
  final String overview;
  final double popularity;
  final String posterPath;
  final String backdropPath;
  final String originalName;
  final double voteAverage;
  final List<Genre> genres;
  final List<Season> seasons;
  final List<int> episodeRunTime;

  SeriesTVDetail({
    required this.id,
    required this.voteCount,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.adult,
    required this.name,
    required this.type,
    required this.status,
    required this.seasons,
    required this.homepage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.originalName,
    required this.backdropPath,
    required this.voteAverage,
    required this.genres,
    required this.episodeRunTime,
  });

  @override
  List<Object?> get props => [
    id,
    voteCount,
    numberOfSeasons,
    numberOfEpisodes,
    adult,
    name,
    type,
    status,
    homepage,
    overview,
    popularity,
    posterPath,
    backdropPath,
    originalName,
    voteAverage,
    genres,
    seasons,
    episodeRunTime,
  ];
}