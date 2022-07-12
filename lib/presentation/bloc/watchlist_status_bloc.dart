import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/get_watchlist_status.dart';

part 'watchlist_status_event.dart';
part 'watchlist_status_state.dart';

class WatchlistStatusBloc extends Bloc<WatchlistStatusEvent, WatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  WatchlistStatusBloc({required this.getWatchListStatus}) : super(WatchlistStatusInitial()) {
    on<GetWatchlistStatusEvent>((event, emit) async{
      final result = await getWatchListStatus.execute(event.id);
      if (result) {
        emit(WatchlistStatusTrue());
      } else {
        emit(WatchlistStatusFalse());
      }
    });
  }
}
