import 'package:ditonton/domain/entities/seriestv/series_tv.dart';
import 'package:ditonton/domain/entities/seriestv/series_tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVSeriesTable.fromEntity(SeriesTVDetail tvSeriesDetail) => TVSeriesTable(
    id: tvSeriesDetail.id,
    name: tvSeriesDetail.name,
    posterPath: tvSeriesDetail.posterPath,
    overview: tvSeriesDetail.overview,
  );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  SeriesTV toEntity() => SeriesTV.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
