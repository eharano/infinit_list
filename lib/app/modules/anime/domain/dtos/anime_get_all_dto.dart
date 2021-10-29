class AnimeGetAllDTO {
  final int page;
  final int perPage;

  const AnimeGetAllDTO({
    this.page = 1,
    this.perPage = 10,
  });

  AnimeGetAllDTO copyWith({
    int? page,
    int? perPage,
  }) {
    return AnimeGetAllDTO(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'page': page, 'per_page': perPage};
  }
}
