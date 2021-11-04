class AnimeDTO {
  final int page;
  final int perPage;

  const AnimeDTO({
    this.page = 1,
    this.perPage = 10,
  });

  AnimeDTO copyWith({
    int? page,
    int? perPage,
  }) {
    return AnimeDTO(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'page': page, 'per_page': perPage};
  }
}
