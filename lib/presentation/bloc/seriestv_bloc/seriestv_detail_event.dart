part of 'seriestv_detail_bloc.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();
}
class OnSeriesDetailShow extends SeriesDetailEvent {
  final int id;
  OnSeriesDetailShow(this.id);

  @override
  List<Object> get props => [];
}
