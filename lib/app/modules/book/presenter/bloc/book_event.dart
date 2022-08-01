part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class BookFetchEvent extends BookEvent {
  final BookDTO params;

  const BookFetchEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}

class BookPaginateEvent extends BookEvent {
  final BookDTO params;

  const BookPaginateEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}
