class BookDTO {
  final int page;
  final int perPage;

  const BookDTO({
    this.page = 1,
    this.perPage = 10,
  });

  BookDTO copyWith({
    int? page,
    int? perPage,
  }) {
    return BookDTO(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'page': page, 'per_page': perPage};
  }
}
