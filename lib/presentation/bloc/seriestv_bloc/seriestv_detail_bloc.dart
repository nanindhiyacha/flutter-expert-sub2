import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../domain/entities/seriestv/series_tv_detail.dart';
import '../../../domain/usecases/get_seriestv_detail.dart';

part 'seriestv_detail_event.dart';
part 'seriestv_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;
  SeriesDetailBloc(this.getTVSeriesDetail) : super(SeriesDetailEmpty()) {
    on<OnSeriesDetailShow>((event, emit) async{
      final id = event.id;
      emit(SeriesDetailLoading());
      final result = await getTVSeriesDetail.execute(id);
      result.fold(
            (failure) {
          emit(SeriesDetailError(failure.message));
        },
            (data) {
          emit(SeriesDetailHasData(data));
        },
      );
    });
  }
}
