import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/errors/http_client_error.dart';
import '../../domain/dtos/dtos.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/entities/book.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookGetAllUseCase useCase;

  BookBloc({
    required this.useCase,
  }) : super(const BookInitialState());

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is BookFetchEvent) {
      yield* mapBookFetchEventToState(event);
    } else if (event is BookPaginateEvent) {
      yield* mapBookPaginateEventToState(event);
    }
  }

  Stream<BookState> mapBookFetchEventToState(BookFetchEvent event) async* {
    yield const BookLoadingState();

    final response = await useCase.call(params: event.params);
    yield response.fold(
      (l) => BookErrorState(error: l.message),
      (r) => BookSuccessState(books: r),
    );
  }

  Stream<BookState> mapBookPaginateEventToState(BookPaginateEvent event) async* {
    yield (state as BookSuccessState).copyWith(isLoading: true);

    var response = await useCase(params: event.params);
    var paginateState = response.fold((left) {
      if (left is HttpClientError && left.statusCode == 400) {
        return ((state as BookSuccessState).copyWith(hasMax: true, isLoading: false));
      } else {
        return (BookErrorState(error: left.message));
      }
    }, (right) {
      return BookSuccessState(
        books: (state as BookSuccessState).books..addAll(right),
        isLoading: false,
      );
    });

    yield const BookLoadingState();
    yield paginateState;
  }
}
