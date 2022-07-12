import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  SearchBloc({required this.searchMovies}) : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await searchMovies.execute(event.query);

      result.fold(
            (failure) => emit(SearchError(failure.message)),
            (result) => emit(SearchLoaded(result)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
