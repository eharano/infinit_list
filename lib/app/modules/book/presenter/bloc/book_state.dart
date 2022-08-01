part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitialState extends BookState {
  const BookInitialState();

  @override
  List<Object?> get props => [];
}

class BookLoadingState extends BookState {
  const BookLoadingState();

  @override
  List<Object?> get props => [];
}

class BookSuccessState extends BookState {
  final List<Book> books;
  final bool hasMax;
  final bool isLoading;

  const BookSuccessState({
    required this.books,
    this.hasMax = false,
    this.isLoading = false,
  });

  BookSuccessState copyWith({
    List<Book>? books,
    bool? hasMax,
    bool? isLoading,
  }) {
    return BookSuccessState(
      books: books ?? this.books,
      hasMax: hasMax ?? this.hasMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [books, hasMax];
}

class BookErrorState extends BookState {
  final String error;

  const BookErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
